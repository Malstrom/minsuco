// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
//= require payola
//= require Chart.bundle

//--- Angle
//= require_tree ./angle/


//--- Skycons
//= require skycons/skycons
//--- Sortable
//= require html.sortable/dist/html.sortable.js
//--- Nestable
//= require nestable/jquery.nestable.js
// --- Bootstrap Tour
//= require bootstrap-tour/build/js/bootstrap-tour-standalone.js
// --- Sweet Alert
//= require sweetalert/dist/sweetalert.min.js

Chartkick.configure({language: "it"});
////= require cable



$(".setting-color").click(function () {
  data = {
    theme: $(this).attr('data-theme'),
    authenticity_token: $( 'meta[name="csrf-token"]' ).attr( 'content' )
  };
  user_id = $(this).attr('data-user-id');

  $.ajax({
    url: "/users/" + user_id + "/theme",
    method: 'patch',
    data: data,
    dataType: "json"
  });
});