// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);



$(function() {
  $('.tab li').click(function() {
    var index = $('.tab li').index(this);
    $('.tab_content').css('display','none');
    $('.tab_content').eq(index).css('display','block');
    $('.tab li').removeClass('tab_current');
    $(this).addClass('tab_current')
    });
  });


