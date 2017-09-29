// Place all the behaviors and hooks related to the matching controller here.
//--- jQuery UI
//= require jquery-ui/jquery-ui
//= require jqueryui-touch-punch/jquery.ui.touch-punch.min
//--- Moment
//= require moment/min/moment-with-locales.min
//--- Fullcalendar
//= require fullcalendar/dist/fullcalendar.min
//= require fullcalendar/dist/gcal
//--- Gmap
//= require jQuery-gMap/jquery.gmap.min
//--- Chosen
//= require chosen_v1.2.0/chosen.jquery.min
//--- Slider ctrl
//= require seiyria-bootstrap-slider/dist/bootstrap-slider.min
//--- DatetimePicker
//= require eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min
//--- Sparklines
//--- Datatables
//= require datatables/media/js/jquery.dataTables.min
//= require datatables-colvis/js/dataTables.colVis
//= require datatables/media/js/dataTables.bootstrap
//--- Filestyle
//= require bootstrap-filestyle/src/bootstrap-filestyle

//--- Input Mask
//= require jquery.inputmask/dist/jquery.inputmask.bundle
//--- Wysiwyg
//= require bootstrap-wysiwyg/bootstrap-wysiwyg
//= require bootstrap-wysiwyg/external/jquery.hotkeys
//--- Parsley
//= require parsleyjs/dist/parsley.min
//--- DatetimePicker
//= require eonasdan-bootstrap-datetimepicker/build/js/bootstrap-datetimepicker.min
//--- Upload
//= require jquery-ui/ui/widget
//= require blueimp-tmpl/js/tmpl
//= require blueimp-load-image/js/load-image.all.min
//= require blueimp-canvas-to-blob/js/canvas-to-blob
//= require blueimp-file-upload/js/jquery.iframe-transport
//= require blueimp-file-upload/js/jquery.fileupload
//= require blueimp-file-upload/js/jquery.fileupload-process
//= require blueimp-file-upload/js/jquery.fileupload-image
//= require blueimp-file-upload/js/jquery.fileupload-audio
//= require blueimp-file-upload/js/jquery.fileupload-video
//= require blueimp-file-upload/js/jquery.fileupload-validate
//= require blueimp-file-upload/js/jquery.fileupload-ui
//--- xEditable
//= require x-editable/dist/bootstrap3-editable/js/bootstrap-editable.min
//--- Validate
//= require jquery-validation/dist/jquery.validate
//--- Steps
//= require jquery.steps/build/jquery.steps
// --- ColorPicker
//= require mjolnic-bootstrap-colorpicker/dist/js/bootstrap-colorpicker.js
// --- Cropper
//= require cropper/dist/cropper.js
// --- Select2
//= require select2/dist/js/select2
//--- Tags input
//= require bootstrap-tagsinput/dist/bootstrap-tagsinput.min

// --- Bootstrap Tour
//= require bootstrap-tour/build/js/bootstrap-tour-standalone.js

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

$('#open').click(function(){
  $( ".open" ).show();
  $( ".close" ).hide();
  $( ".payola-checkout-button" ).show();
});

$('#close').click(function(){
  $( ".open" ).hide();
  $( ".close" ).show();
  // $( ".payola-checkout-button" ).hide();
});

$('#payed_submit').click(function(){
  $('form').submit();
});

$('#add_like_button').click(function () {
  raceId = $(this).data('race');
  userId = $(this).data('user');
  likes  = $(this).data('likes');

  $.ajax({
    url: "/races/" + raceId + "/like",
    method: 'get',
    success: function(){
      $("#like_widget").html("<button id=\"likes_counter\" type=\"button\" class=\"btn btn-default btn-xs\">\n" +
        "            <em class=\"fa fa-thumbs-up text-info\"></em>\n" +
        "            <span class='text-info'>" + (parseInt(likes) + 1) + "</span>\n" +
        "            </button>"
      );
    }
  });
});

$.urlParam = function(name){
  var results = new RegExp('[\?&]' + name + '=([^&#]*)').exec(window.location.href);
  if (results==null){
    return null;
  }
  else{
    return decodeURI(results[1]) || 0;
  }
};


(function(window, document, $, undefined){

  if ( ! $.fn.dataTable ) return;

  $(function(){


    $('#inAppFriendsTable').dataTable({
      "pagingType": "full",
      'paging':   true,  // Table pagination
      'ordering': false,  // Column ordering
      'info':     true,  // Bottom left status text
      'responsive': true, // https://datatables.net/extensions/responsive/examples/
      // Text translation options
      // Note the required keywords between underscores (e.g _MENU_)
      oLanguage: {
        sSearch:      'Cerca',
        sLengthMenu:  '_MENU_ records per pagina',
        info:         'Mostra page _PAGE_ of _PAGES_',
        zeroRecords:  'Non hai amici - mi spiace',
        infoEmpty:    'Non ho trovato nulla',
        infoFiltered: '(filtered from _MAX_ total records)'
      }
    });

    $('#allFriendsTable').dataTable({
      "pagingType": "full",
      'paging':   true,  // Table pagination
      'ordering': false,  // Column ordering
      'info':     true,  // Bottom left status text
      'responsive': true, // https://datatables.net/extensions/responsive/examples/
      // Text translation options
      // Note the required keywords between underscores (e.g _MENU_)
      oLanguage: {
        sSearch:      'Cerca',
        sLengthMenu:  'Records per pagina _MENU_',
        info:         'Mostra _START_ to _END_ of _TOTAL_ amici',
        zeroRecords:  'Non hai amici - mi spiace',
        infoEmpty:    'Non ho trovato nulla',
        infoFiltered: '(filtered from _MAX_ total records)'
      }
    });
    $('#userRaceTable').dataTable({
      "pagingType": "full",
      'paging':   true,  // Table pagination
      'ordering': true,  // Column ordering
      'info':     true,  // Bottom left status text
      'responsive': true, // https://datatables.net/extensions/responsive/examples/
      // Text translation options
      // Note the required keywords between underscores (e.g _MENU_)
      oLanguage: {
        sSearch:      'Cerca',
        sLengthMenu:  'Records per pagina _MENU_',
        info:         'Mostra _START_ to _END_ of _TOTAL_ amici',
        zeroRecords:  'Non hai amici - mi spiace',
        infoEmpty:    'Non ho trovato nulla',
        infoFiltered: '(filtered from _MAX_ total records)'
      }
    });
  });

})(window, document, window.jQuery);