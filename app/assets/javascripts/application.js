// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
//
//= require jquery_nested_form

//= require payola
//= require Chart.bundle

//= require social-share-button

//--- Angle
//= require_tree ./angle/

//--- Skycons
//= require skycons/skycons
//--- Sortable
//= require html.sortable/dist/html.sortable.js
//--- Nestable
//= require nestable/jquery.nestable.js
// --- Sweet Alert
//= require sweetalert/dist/sweetalert.min.js


//= require enjoyhint/enjoyhint


//initialize instance
var enjoyhint_instance = new EnjoyHint({});

//simple config.
//Only one step - highlighting(with description) "New" button
//hide EnjoyHint after a click on the button.
var enjoyhint_script_steps = [
  {
    'click .fa-rocket' : 'Questi sono i tuoi progressi'
  },
  {
    'click .some_panel' : 'Click on this panel'
  }
];

//set script config
enjoyhint_instance.set(enjoyhint_script_steps);

//run Enjoyhint script
enjoyhint_instance.run();

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

$('.info')
  // .tooltip({ content: 'Click to close', position: { my: 'left center', at: 'right center' }, items: '*' })
  .tooltip('open')
  .on('mouseout focusout', function(event) {
    event.stopImmediatePropagation();
  })
  .on('tooltipopen', function(e) {
    var self = this,
      $tooltip = $('#' + this.getAttribute('aria-describedby'));

    $tooltip.on('click', function() {
      $(self).tooltip('close');
    })
  });

