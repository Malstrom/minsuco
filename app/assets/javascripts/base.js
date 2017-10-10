// This is a manifest file that'll be compiled into base.js, which will include all the files
// listed below.
//--- Bootstrap
//= require bootstrap/dist/js/bootstrap
//--- Storage API
//= require jQuery-Storage-API/jquery.storageapi
//--- jQuery easing
//= require jquery.easing/js/jquery.easing
//--- Animo
//= require animo.js/animo
//--- Slimscroll
//= require slimScroll/jquery.slimscroll.min
//--- Screenfull
//= require screenfull/dist/screenfull
//--- Localize
//= require jquery-localize-i18n/dist/jquery.localize

$('label').addClass('lead');


$('.gradeX').hover(
  function () {
    $(this).find('.actions').removeClass('hidden').addClass('visible');
  },
  function () {
    $(this).find('.actions').removeClass('visible').addClass('hidden');
  }
);
