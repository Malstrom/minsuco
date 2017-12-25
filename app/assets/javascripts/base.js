// This is a manifest file that'll be compiled into base.js, which will include all the files
// listed below.
//--- Modernizr
//= require modernizr/modernizr.custom
//--- jQuery
//= require jquery/dist/jquery
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

//= require jquery.filterizr.min.js


$('label').addClass('lead');

$('.gradeX').hover(
  function () {
    $(this).find('.actions').removeClass('hidden').addClass('visible');
  },
  function () {
    $(this).find('.actions').removeClass('visible').addClass('hidden');
  }
);


$('#user_rui').change(function () {
  kind = this.value.charAt(0);
  switch(kind) {
    case 'a':
      $('#userKind').html('Agente');
      break;
    case 'b':
      $('#userKind').html('Broker');
      break;
    case 'c':
      $('#userKind').html('Sub-agente');
      break;
    case 'd':
      $('#userKind').html('Agente');
      break;
    default:
      $('#userKind').html('Non valido');
  }
});


$( document ).ready(function() {

  // hide spinner
  $(".spinner").hide();


  // show spinner on AJAX start
  $(document).ajaxStart(function(){
    $(".spinner").show();
  });

  // hide spinner on AJAX stop
  $(document).ajaxStop(function(){
    $(".spinner").hide();
  });

});

$(document).ajaxStop(function(){
  $(".spinner").delay(3000).hide(0);
});