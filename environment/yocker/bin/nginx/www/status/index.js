$(window).load(function () {
    /*global _ */
    $(document).ready(function () {
        var statusTable = {
            LABEL_MISSING: '-',
            LINE_BREAK: '<br/>',

            fetch: function () {
                $.ajax({
                    url: "/containers.json",
                    dataType: "json",
                    complete: function (response) {
                        var result = statusTable.parseResponse(response);
                        statusTable.render(result.containers);
                    }
                });
            },

            render: function (containers) {
                if (containers) {
                    $('#status-table').dynatable({
                        dataset: {
                            records: containers
                        }
                    });
                }
            },

            toHTML: function (value) {
                if (_.isArray(value) && !_.isEmpty(value)) {
                    return value.map(JSON.stringify).join(statusTable.LINE_BREAK);
                }
                if (_.isObject(value) && !_.isEmpty(value)) {
                    return JSON.stringify(value);
                }
                return statusTable.LABEL_MISSING;
            },

            parseResponse: function (response) {
                response = JSON.parse(response.responseText);
                var result = {
                    containers: {}
                };
                if (response) {
                    _.each(response, function (values, label) {
                        switch (label) {
                        case "Containers":
                            result.containers = statusTable.parseContainers(values);
                            break;
                        default:
                        }
                    });
                }
                return result;
            },

            parseContainers: function (values) {
                var containers = [];
                if (values) {
                    _.each(values, function (container) {
                        var result = {
                            name: container.Name || statusTable.LABEL_MISSING,
                            hostname: container.Hostname || statusTable.LABEL_MISSING,
                            id: container.ID || statusTable.LABEL_MISSING,
                            status: (container.State && container.State.Running) ?
                                    "Running" :
                                    JSON.stringify(container.State)
                        };
                        result.addresses = statusTable.parseAddresses(container.Addresses);
                        result.networks = statusTable.parseNetworks(container.Networks);
                        result.compose = statusTable.parseCompose(container.Labels);
                        var service = statusTable.parseService(container.Env);
                        result.service = statusTable.LABEL_MISSING;
                        if (service && service.ports) {
                            result.service = service.ports.map(function (port) {
                                var prefix = port == "443" ? "https://" : "http://",
                                        suffix = (port == "80" || port == "443") ? '' : ":" + port,
                                        url = prefix + service.name + suffix,
                                        link = $('<a>').attr('target', '_blank').attr('href', url).html(url);
                                return $('<div>').append(link.clone()).html();
                            }).join(statusTable.LINE_BREAK);
                        }
                        result.addresses = statusTable.toHTML(result.addresses);
                        result.networks = statusTable.toHTML(result.networks);
                        result.compose = statusTable.toHTML(result.compose);
                        containers.push(result);
                    });
                }
                return containers;
            },

            parseAddresses: function (values) {
                var result = [];
                _.each(values, function (value) {
                    result.push({host_ip: value.HostIP, host_port: value.HostPort, port: value.Port});
                });
                return result;
            },

            parseNetworks: function (values) {
                var result = [];
                _.each(values, function (value) {
                    result.push({ip: value.IP, name: value.Name, port: value.Port});
                });
                return result;
            },

            parseService: function (values) {
                var result = {};
                if (values.SERVICE_NAME) {
                    result.name = values.SERVICE_NAME;
                }
                if (values.SERVICE_PORT_MAPPING) {
                    var ports = values.SERVICE_PORT_MAPPING.split(',')
                            .map(function (s) {
                                return (s.indexOf(':') === -1) ? s : s.substring(0, s.indexOf(':'))
                            })
                            .map(function (s) {
                                return (s.indexOf('/') === -1) ? s : s.substring(0, s.indexOf('/'))
                            });
                    result.ports = ports;
                }
                return result;
            },

            parseCompose: function (values) {
                var result = {};
                if (values["com.docker.compose.project"]) {
                    result.project = values["com.docker.compose.project"];
                }
                if (values["com.docker.compose.service"]) {
                    result.service = values["com.docker.compose.service"];
                }
                if (values["com.docker.compose.container-number"]) {
                    result.number = values["com.docker.compose.container-number"];
                }
                return result;
            }
        };

        // Start statusTable
        statusTable.fetch();

        // Activate reloading buttons
        $('.bind-reload').on('click', function (e) {
            e.preventDefault();
            location.reload();
        });
        $('.bind-containers-reload').on('click', function (e) {
            e.preventDefault();
            statusTable.fetch();
        });
    });
});