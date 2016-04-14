$(window).load(function() {
  /*global _ */
  $(document).ready(function() {
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