$(window).load(function() {
  /*global _ */
  $(document).ready(function() {
    function initMenu(){
      var hostname = location.hostname.split('.'),
          subdomain = hostname.shift(),
          domain = hostname.join('.'),
          $menu = $('#menu'),
          $contentContainer = $menu.next('.tab-content'),
          prepareUrl = function(url) {
            return url.replace('{DOMAIN}', domain);
          }
          items = {
            index: {
              url: prepareUrl("https://status.{DOMAIN}#nginx"),
              icon: 'fa-map-o',
              label: 'Index'
            },
            containers: {
              url: prepareUrl("https://status.{DOMAIN}#containers"),
              icon: 'fa-play',
              label: 'Containers'
            },
            images: {
              url: prepareUrl("https://status.{DOMAIN}#images"),
              icon: 'fa-cubes',
              label: 'Images'
            },
            info: {
              url: prepareUrl("https://status.{DOMAIN}#info"),
              icon: 'fa-server',
              label: 'Info'
            },
            version: {
              url: prepareUrl("https://status.{DOMAIN}#version"),
              icon: 'fa-arrow-circle-o-up',
              label: 'Version'
            },
            memory: {
              url: prepareUrl("https://status.{DOMAIN}/api/memory.txt"),
              icon: 'fa-signal',
              label: 'Memory'
            },
            cadvisor: {
              url: prepareUrl("https://cadvisor.{DOMAIN}"),
              icon: 'fa-tachometer',
              label: 'cAdvisor'
            },
            ide: {
              url: prepareUrl("https://ide.{DOMAIN}"),
              icon: 'fa-pencil-square-o',
              label: 'ide'
            },
            terminal: {
              url: prepareUrl("https://terminal.{DOMAIN}"),
              icon: 'fa-terminal',
              label: 'Terminal'
            },
            logs: {
              url: prepareUrl("https://logs.{DOMAIN}"),
              icon: 'fa-newspaper-o',
              label: 'Logs'
            },
            nginx: {
              url: prepareUrl("https://nginx.{DOMAIN}"),
              icon: 'fa-globe',
              label: 'Nginx'
            },
            uptime: {
              url: prepareUrl("https://uptimerobot.com/dashboard"),
              icon: 'fa-bell',
              label: 'Uptime'
            },
            reload: {
              myclass: "bind-reload",
              icon: 'fa-refresh',
              label: 'Reload'
            }
          };

      if($contentContainer.length === 0) {
        $contentContainer = $('<div>').addClass('tab-content');
        $menu.after($contentContainer);
      }
      $menu.html('').addClass("nav nav-tabs bind-toggable").attr("role","tablist");
      $contentContainer.html('');
      $('#domain').html('@'+domain);
      $('title').html('monitor@'+domain);

      _.each(items, function(item, key) {
        var $li = $('<li role="presentation">'),
            $a= $('<a role="tab" data-toggle="tab">')
                .addClass('bind-select-tab')
                .attr('href','#'+key),
            $i = $('<i class="fa">'),
            $content = $('<div role="tabpanel" class="tab-pane">');

            if(item.url) {
              $a.attr('data-url',item.url)
            }
            if(item.myclass) {
              $a.addClass(item.myclass);
            }
            if(item.icon) {
              $a.append($i.addClass(item.icon));
            }
            if(item.label) {
              $a.append(' '+item.label);
            }
            $li.append($a);
            $menu.append($li);
            $contentContainer.append($content.attr('id',key));
      });
    }
    initMenu();


    // Activate reloading buttons
    $('.bind-reload').on('click', function(e) {
      e.preventDefault();
      location.reload();
    });
    $('.bind-select-tab').on('click', function(e) {
      e.preventDefault();
      var $this = $(this),
        target = $this.attr('href'),
        $target = $(target),
        url = $this.data('url'),
        $iframe = $target.children('iframe');
      location.hash = target;

      if ($iframe.length === 0) {
        var $reload = $('<a class="btn btn-link btn-sm pull-right bind-toggable" target="_blank"><i class="fa fa-external-link"></i> Open in new window</a>').attr('href', url),
          $kill = $('<a class="btn btn-link btn-sm pull-right bind-iframe-kill bind-toggable" href="#"><i class="fa fa-hand-scissors-o"></i> Kill</a>'),
          $refresh = $('<a class="btn btn-link btn-sm pull-right bind-iframe-reload bind-toggable" href="#"><i class="fa fa-refresh"></i> Reload</a>');
        $iframe = $('<iframe>').attr('width', "100%").attr('height', "100%");
        $target
            .append($reload)
            .append($kill)
            .append($refresh)
            .append($iframe);
        $iframe.attr('src', url);
      }
    });
    $('body').on('click', '.bind-iframe-reload', function(e) {
      var $iframe = $(this).siblings('iframe'),
        url = $iframe.attr('src'),
        parser = document.createElement('a'),
        timestamp = new Date().getTime();

      parser.href = url;
      parser.protocol; // => "http:"
      parser.hostname; // => "example.com"
      parser.port; // => "3000"
      parser.pathname; // => "/pathname/"
      parser.search; // => "?search=test"
      parser.hash; // => "#hash"
      parser.host; // => "example.com:3000"

      parser.search += (_.isEmpty(parser.search) ? '?' : '&') + timestamp;
      $iframe.attr('src',
        parser.protocol + '//' +
        parser.host +
        parser.pathname +
        parser.search +
        parser.hash
      );
    });
    $('body').on('click', '.bind-iframe-kill', function(e) {
      e.preventDefault();
      $(this).parent().children().remove();
    });
    $('body').on('click', '.bind-minimize', function(e) {
      e.preventDefault();
      var $this = $(this),
          $icon = $this.children('i');

      $this
        .toggleClass('minimize');
      $icon
        .toggleClass('fa-caret-up')
        .toggleClass('fa-caret-down');
      $('.bind-toggable').toggle();
    });

    if (location.hash === "" || location.hash === "#") {
      $('#menu > li').first().children('a').click();
    } else {
      $("[href='" + location.hash + "']").click();
    }
  });
});