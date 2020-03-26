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


$(function(){
  $('#item_price').on("change",function(){
    var number = $('#item_price').val();
    var price =  parseInt(number);
    var commission = price  * 0.1
    var profit = price  * 0.9
    var commission = commission.toLocaleString();
    var profit = profit.toLocaleString();
    $(".commission-input").text(commission)
    $(".profit-input").text(profit)
});
});


