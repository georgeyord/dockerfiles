$(window).load(function() {
  /*global _ */
  $(document).ready(function() {
    var dyna = {
      LABEL_MISSING: '-',
      LINE_BREAK: '<br/>',
      id: '#dynatable',

      start: function() {
        var _this = this;
        $.ajax({
          url: _this.api,
          dataType: "json",
          complete: function(response) {
            var result = _this.parseResponse(response);
            _this.render(result);
          }
        });
      },

      render: function(result) {
        if (result) {
          this.prepare();
          $(this.id).dynatable({
            dataset: {
              records: result
            }
          });
        }
      },

      prepare: function() {
        var $target = $(this.id),
          $thead = $target.children('thead'),
          $tbody = $target.children('tbody');
        $target.addClass("table table-striped");

        if ($thead.length === 0) {
          $thead = $('<thead>');
          var $tr = $('<tr>');

          _.each(this.columns, function(value) {
            var $th = $('<th>').html(value);
            $tr.append($th);
          });

          $thead.append($tr);
          $target.append($thead);
        }
        if ($tbody.length === 0) {
          $tbody = $('<tbody>');
          $target.append($tbody);
        }
      },

      toHTML: function(value) {
        if (_.isArray(value) && !_.isEmpty(value)) {
          return value.map(JSON.stringify).join(this.LINE_BREAK);
        }
        if (_.isObject(value) && !_.isEmpty(value)) {
          return JSON.stringify(value);
        }
        return this.LABEL_MISSING;
      },

      toLength: function(value, length) {
        return value.substring(0, length || 10);
      },

      toFormattedDate: function(value) {
        var date  = new Date(value * 1000);
        return moment(date).format('YY-MM-DD hh:mm:ss');
      },

      toReadableSize: function(bytes, si) {
        var thresh = si ? 1000 : 1024;
        if (Math.abs(bytes) < thresh) {
          return bytes + ' B';
        }
        var units = si ? ['kB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'] : ['KiB', 'MiB', 'GiB', 'TiB', 'PiB', 'EiB', 'ZiB', 'YiB'];
        var u = -1;
        do {
          bytes /= thresh;
          ++u;
        } while (Math.abs(bytes) >= thresh && u < units.length - 1);
        return bytes.toFixed(1) + ' ' + units[u];
      }
    };

    var service = {
      containers: {
        api: "/api/containers.json",
        columns: [
          "Name",
          "Status",
          // https://www.dynatable.com#sorting
          "Created",
          "Image",
          "Id",
          "Addresses",
          "Compose",
          "Networks"
        ],

        parseResponse: function(response) {
          var result = [];
          response = JSON.parse(response.responseText);
          if (response) {
            result = this.parseContainers(response);
          }
          return result;
        },

        parseContainers: function(values) {
          var result = [],
            _this = this;
          if (values) {
            _.each(values, function(container) {
              var data = {
                name: container.Names.join(' ') || _this.LABEL_MISSING,
                status: container.Status || _this.LABEL_MISSING,
                created: (container.Created ? _this.toFormattedDate(container.Created) : _this.LABEL_MISSING),
                image: container.Image || _this.LABEL_MISSING,
                id: container.Id ? _this.toLength(container.Id) : _this.LABEL_MISSING
              };
              data.networks = _this.parseNetworks(container.NetworkSettings);
              data.addresses = _this.parsePorts(container.Ports);
              data.compose = _this.parseCompose(container.Labels);
              data.addresses = _this.toHTML(data.addresses);
              data.networks = _this.toHTML(data.networks);
              data.compose = _this.toHTML(data.compose);
              result.push(data);
            });
          }
          return result;
        },

        parseNetworks: function(values) {
          var result = [];
          if (values.Networks) {
            _.each(values.Networks, function(value, key) {
              result.push({
                name: key,
                gateway: value.Gateway,
                ip: value.IPAddress
              });
            });
          } else {
            result.push(this.LABEL_MISSING);
          }
          return result;
        },

        parsePorts: function(values) {
          var result = [];
          _.each(values, function(value) {
            var port = {
              port: value.PrivatePort,
              type: value.Type
            };
            if (value.PublicPort) {
              port.exposed_port = value.PublicPort;
            }
            if (value.IP) {
              port.host_ip = value.IP;
            }
            result.push(port);
          });
          return result;
        },

        parseCompose: function(values) {
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
          if (values["com.docker.compose.oneoff"]) {
            result.oneoff = values["com.docker.compose.oneoff"];
          }
          return result;
        }
      },
      nginx: {
        api: "/api/nginx.json",
        columns: [
          "Name",
          "Domain name",
          "External port",
          "Internal port",
          "Internal IP",
          "Ssl enabled",
          "ID"
        ],

        parseResponse: function(response) {
          var result = [];
          response = JSON.parse(response.responseText);
          if (response) {
            result = this.parseContainers(response);
          }
          return result;
        },

        parseContainers: function(values) {
          var result = [],
            _this = this;
          if (values) {
            _.each(values, function(container) {
              var data = {
                name: container.ServiceName || _this.LABEL_MISSING,
                domainName: _this.createUrl(container),
                externalPort: container.ExternalPort || _this.LABEL_MISSING,
                internalPort: container.InternalPort || _this.LABEL_MISSING,
                internalIp: container.InternalIP || _this.LABEL_MISSING,
                id: container.ID ? _this.toLength(container.ID) : _this.LABEL_MISSING,
                sslEnabled: container.SslEnabled || _this.LABEL_MISSING
              };
              result.push(data);
            });
          }
          return result;
        },

        createUrl: function(container) {
          var prefix = container.SslEnabled ? "https://" : "http://",
            suffix = (container.ExternalPort == "80" || container.ExternalPort == "443") ? '' : ":" + container.ExternalPort,
            url = prefix + container.ServiceName + suffix,
            link = $('<a>').attr('target', '_blank').attr('href', url).html(url);
          return $('<div>').append(link.clone()).html();
        }
      },
      images: {
        api: "/api/images.json",
        columns: [
          "Tags",
          "Created",
          "Size",
          "VirtualSize",
          "Labels"
        ],

        parseResponse: function(response) {
          var result = [];
          response = JSON.parse(response.responseText);
          if (response) {
            result = this.parseImages(response);
          }
          return result;
        },

        parseImages: function(values) {
          var result = [],
            _this = this;
          if (values) {
            _.each(values, function(container) {
              var data = {
                tags: container.RepoTags.join(' ') || _this.LABEL_MISSING,
                created: (container.Created ? _this.toFormattedDate(container.Created) : _this.LABEL_MISSING),
                size: _this.toReadableSize(container.Size) || _this.LABEL_MISSING,
                labels: JSON.stringify(container.Labels) || _this.LABEL_MISSING
              };
              result.push(data);
            });
          }
          return result;
        }
      },
      info: {
        api: "/api/info.json",
        columns: [
          "Label",
          "Details"
        ],

        parseResponse: function(response) {
          var result = [];
          response = JSON.parse(response.responseText);
          if (response) {
            result = this.parseInfo(response);
          }
          return result;
        },

        parseInfo: function(values) {
          var result = [],
            _this = this;
          if (values) {
            result.push({
              label: 'Name',
              details: values.Name
            });
            result.push({
              label: 'Docker server version',
              details: values.ServerVersion
            });
            result.push({
              label: 'Containers running',
              details: values.ContainersRunning
            });
            result.push({
              label: 'Containers',
              details: values.Containers
            });
            result.push({
              label: 'Images',
              details: values.Images
            });
            result.push({
              label: 'System time',
              details: values.SystemTime
            });
            result.push({
              label: 'LoggingDriver',
              details: values.LoggingDriver
            });
            result.push({
              label: 'OS type',
              details: values.OSType
            });
            result.push({
              label: 'OperatingSystem',
              details: values.OperatingSystem
            });
            result.push({
              label: 'Architecture',
              details: values.Architecture
            });
            result.push({
              label: 'Server address',
              details: values.IndexServerAddress
            });
            result.push({
              label: 'Registry config',
              details: JSON.stringify(values.RegistryConfig)
            });
            result.push({
              label: 'Cores',
              details: values.NCPU
            });
            result.push({
              label: 'MemTotal',
              details: this.toReadableSize(values.MemTotal)
            });
          }
          return result;
        }
      },
      version: {
        api: "/api/version.json",
        columns: [
          "Label",
          "Details"
        ],

        parseResponse: function(response) {
          var result = [];
          response = JSON.parse(response.responseText);
          if (response) {
            result = this.parseInfo(response);
          }
          return result;
        },

        parseInfo: function(values) {
          var result = [],
            _this = this;
          if (values) {
            result.push({
              label: 'Version version',
              details: values.Version
            });
            result.push({
              label: 'Api version',
              details: values.ApiVersion
            });
            result.push({
              label: 'Git commit',
              details: values.GitCommit
            });
            result.push({
              label: 'Go version',
              details: values.GoVersion
            });
            result.push({
              label: 'Os',
              details: values.Os
            });
            result.push({
              label: 'Arch',
              details: values.Arch
            });
            result.push({
              label: 'KernelVersion',
              details: values.KernelVersion
            });
          }
          return result;
        }
      }
    };
    var running = {};

    $(window).bind('hashchange', function(e) {
      var settings = service[location.hash.split('#')[1]] || null;

      if (settings) {
        var running = $.extend(true, {}, dyna, settings);
        // Start dyna
        running.start.call(running);
      }
    });

    var settings = service[location.hash.split('#')[1]] || null;
    if (settings) {
      var running = $.extend(true, {}, dyna, settings);
      // Start dyna
      running.start.call(running);
    }

    // Activate reloading buttons
    $('.bind-reload').on('click', function(e) {
      e.preventDefault();
      location.reload();
    });
    $('.bind-containers-reload').on('click', function(e) {
      e.preventDefault();
      running.start();
    });
  });
});