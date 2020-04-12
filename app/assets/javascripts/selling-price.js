$(function(){
  $('.input-price').on("input",function(){
    var price = $('.input-price').val();
    // カンマがあると下の手数料の計算がおかしくなるためここで一旦外します↓
    var number = price.replace(/,/g, '');
    // 販売手数料、販売利益の計算
    var commission = number  * 0.1
    var profit = number  * 0.9
    // commissionとprofitに３桁区切りのカンマ付与
    var comma_commission = commission.toLocaleString();
    var comma_profit = profit.toLocaleString();
    $(".commission-input").text(comma_commission)
    $(".profit-input").text(comma_profit)
});
});
