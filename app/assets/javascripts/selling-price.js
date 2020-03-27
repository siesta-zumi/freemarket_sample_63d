$(function(){
  $('#item_price').on("input",function(){
    var number = $('#item_price').val();
    var price =  parseInt(number);
    // 販売手数料、販売利益の計算
    var commission = price  * 0.1
    var profit = price  * 0.9
    // commissionとprofitに３桁区切りのカンマ付与
    var comma_commission = commission.toLocaleString();
    var comma_profit = profit.toLocaleString();
    $(".commission-input").text(comma_commission)
    $(".profit-input").text(comma_profit)
});
});
