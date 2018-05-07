// This is a manifest file that'll be compiled into base.js, which will include all the files
// listed below.
//--- Modernizr

//--- jQuery
//= require jquery/dist/jquery
//= require jquery-ui/jquery-ui

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
//= require jquery.maskMoney.min.js

//--- Input Mask
//= require jquery.inputmask/dist/jquery.inputmask.bundle
//
// --- loader spinner
//= require gasparesganga-jquery-loading-overlay

// Show full page LoadingOverlay
$('#googleImport').click(function () {
  $.LoadingOverlay("show");
});

$('#friends_modal').ready(function() {
  $.LoadingOverlay("hide");
});

// Hide it after 3 seconds
setTimeout(function(){
  $.LoadingOverlay("hide");
}, 10000);

$(".money").maskMoney({thousands:',', decimal:'.', suffix: ' €', precision: 2, affixesStay:false});

$('.gradeX').hover(
  function () {
    $(this).find('.actions').removeClass('hidden').addClass('visible');
  },
  function () {
    $(this).find('.actions').removeClass('visible').addClass('hidden');
  }
);

$('#user_rui').keypress(function () {
  kind = this.value.charAt(0);
  switch(kind.toLowerCase()) {
    case 'a':
      $('#userKind').val('Agente');
      break;
    case 'b':
      $('#userKind').val('Broker');
      break;
    case 'c':
      $('#userKind').val('Produttori diretti');
      break;
    case 'd':
      $('#userKind').val('banche / intermediari finanziari');
      break;
    case 'e':
      $('#userKind').val('ABD esterni');
      break;
    default:
      $('#userKind').val('Non valido');
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



(function(h,o,t,j,a,r){
  h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
  h._hjSettings={hjid:871914,hjsv:6};
  a=o.getElementsByTagName('head')[0];
  r=o.createElement('script');r.async=1;
  r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
  a.appendChild(r);
})(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');