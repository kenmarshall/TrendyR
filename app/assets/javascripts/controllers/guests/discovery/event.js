//= require jquery/jquery.infinitescroll

(function($) {
  $(function() {
    var path = Routes.events_discovery_index_path(),
      imgLoader = '/assets/loading.gif',
      msgTemplate = $('<div class="text-center p-tb20"><img alt="Loading" src="' + imgLoader + '"></div>');

    $('.all-content .music-block').infinitescroll({
      debug: false,
      loading: {
        finishedMsg: '',
        selector: '.infinite-loader',
        speed: '_default',
        img: imgLoader,
        msg: msgTemplate
      },
      appendCallback: true,
      template: function (response) {
        return response.template;
      },
      navSelector: '#footer',
      dataType: 'json',
      path: function(page) {
        var params = _.defaults({ page: page }, gon.q || {});
        return [path, '?', $.param(params)].join('');
      }
    });
  });
})(jQuery);
