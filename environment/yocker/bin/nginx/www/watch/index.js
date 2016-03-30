$(window).load(function () {
    /*global _ */
    $(document).ready(function () {
        // Activate reloading buttons
        $('.bind-reload').on('click', function (e) {
            e.preventDefault();
            location.reload();
        });
        $('.bind-select-tab').on('click', function (e) {
            e.preventDefault();
            var $this = $(this),
                target = $this.attr('href'),
                $target = $(target),
                url = $this.data('url'),
                $iframe = $target.children('iframe');
                location.hash = target;

                if($iframe.length === 0) {
                    var $reload = $('<a class="btn btn-link btn-sm pull-right" target="_blank">Open in new window <i class="fa fa-external-link"></i></a>').attr('href',url),
                        $refresh = $('<a class="btn btn-link btn-sm pull-right bind-iframe-reload" href="#">Reload <i class="fa fa-refresh"></i></a>');
                    $iframe = $('<iframe>').attr('width', "100%").attr('height',"100%");
                    $target.append($reload).append($refresh).append($iframe);
                    $iframe.attr('src', url);
                }
        });
        $('body').on('click', '.bind-iframe-reload', function (e) {
            var $iframe = $(this).siblings('iframe');
            $iframe.attr('src', function ( i, val ) { return val; })
        });

        if(location.hash === "" || location.hash === "#"){
            $('#menu > li').first().children('a').click();
        } else {
            $( "[href='"+location.hash+"']" ).click();
        }
    });
});