// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//

//= require onboarding.js
//= require payola

//--- Angle
//= require_tree ./angle/

//= require jquery_nested_form

//= require jquery
//= require jquery_ujs



$('.datetimepicker').datetimepicker({
  format: 'DD/MM/YYYY',
  locale: 'it',
  showTodayButton: true,
  icons: {
    time: 'fa fa-clock-o',
    date: 'fa fa-calendar',
    up: 'fa fa-chevron-up',
    down: 'fa fa-chevron-down',
    previous: 'fa fa-chevron-left',
    next: 'fa fa-chevron-right',
    today: 'fa fa-crosshairs',
    clear: 'fa fa-trash'
  }
});
