// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require data-confirm-modal
//= require turbolinks
//= require_tree .

var data_conditional = function () {
  return $('[data-conditional]').map(function (i, element) {
    var condition = element.getAttribute('data-conditional').split(':'),
        name = '[id*=' + condition.slice(-1)[0] + ']',
        checked = $(name)[0].checked;

    if (condition.length > 1 && condition[0] == "not") checked = !checked;

    if (checked) { $(element).addClass('visible'); } else { $(element).removeClass('visible'); }
    return name;
  });
};

$(document).ready(function () {
  data_conditional().each(function (i, element) {
    $(element).change(data_conditional);
  });
  $('[data-toggle="tooltip"]').tooltip();

  $("body").keypress(function (e) {
    var tag = e.target.tagName.toLowerCase();

    // Alphanumeric keys + /
    if(
      tag != 'input' &&
      tag != 'textarea' &&
       ((e.keyCode > 46 && e.keyCode < 58) ||
        (e.keyCode > 64 && e.keyCode < 91) ||
        (e.keyCode > 96 && e.keyCode < 123) ||
         e.keyCode === 0)
      ) {

      // We don't want to capture /
      if(e.keyCode === 47) {
        e.preventDefault();
      }
      $("#search").select();
    }
  }).keyup(function (e) {
    if(e.keyCode === 27) {
      $('#search').blur();
    }
  });
});
