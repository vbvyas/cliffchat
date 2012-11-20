// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .
$(document).ready(function() {
  $('#minipost_content').focus(function() {
    $('#minipost_char_count').text((150 - $('#minipost_content').val().length) + " characters left");
    });
  $('#minipost_content').keydown(function() {
    $('#minipost_char_count').text((150 - $('#minipost_content').val().length) + " characters left");
    });
});

