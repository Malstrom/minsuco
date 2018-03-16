// Place all the behaviors and hooks related to the matching controller here.
//--- Flot
//= require flot/jquery.flot
//= require flot.tooltip/js/jquery.flot.tooltip.min
//= require flot/jquery.flot.resize
//= require flot/jquery.flot.pie
//= require flot/jquery.flot.time
//= require flot/jquery.flot.categories
//= require flot-spline/js/jquery.flot.spline.min
// --- EasyPie
//= require jquery.easy-pie-chart/dist/jquery.easypiechart.js
//--- Moment
//= require moment/min/moment-with-locales.min
//--- jQuery Vector map (only dashboard v3)
//= require ika.jvectormap/jquery-jvectormap-1.2.2.min
//= require ika.jvectormap/jquery-jvectormap-world-mill-en
//= require ika.jvectormap/jquery-jvectormap-us-mill-en
// --- enjoyhint
//= require enjoyhint/enjoyhint


//initialize instance
var enjoyhint_instance = new EnjoyHint({});

//simple config.
//Only one step - highlighting(with description) "New" button
//hide EnjoyHint after a click on the button.
var enjoyhint_script_steps = [
  {
    'click .modal-dialog' : 'Benvenuto, abbiamo bisogno di alcune informazioni'
  },
  {
    'click .some_panel' : 'Click on this panel'
  }
];

//set script config
enjoyhint_instance.set(enjoyhint_script_steps);

//run Enjoyhint script



var $myDiv = $('.modal-dialog');

// if ( $myDiv.length){
  enjoyhint_instance.run();
// }