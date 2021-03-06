//= require jquery.min.js
//= require jquery_ujs
//= require bootstrap.min.js
//= require controllers/admin/metis-menu.min

$(function() {

  $('#side-menu').metisMenu();

  $(window).bind("load resize", function() {
    var topOffset = 50;
    var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
    if (width < 768) {
      $('div.navbar-collapse').addClass('collapse');
      topOffset = 100;
    } else {
      $('div.navbar-collapse').removeClass('collapse');
    }

    var height = (this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height;
    height = height - topOffset;
    if (height < 1) height = 1;
    if (height > topOffset) {
      $("#page-wrapper").css("min-height", (height) + "px");
    }
  });

  $('#batch-checkbox').on('click', function() {
    var state = this.checked;
    $('.batch-checkbox').each(function() {
      this.checked = state;
    });
  });

});
