$(document).ready(function () {
  $(".file").on('change', function(){
     var fileprop = $(this).prop('files')[0],
         find_img = $(this).parent().find('img'),
         filereader = new FileReader(),
         view_box = $(this).parent('.view_box');
     
    if(find_img.length){
       find_img.nextAll().remove();
       find_img.remove();
    }
     
    var img = '<div class="img_view"><img alt="" class="img"><p><a href="#" class="img_del">画像を削除する</a></p></div>';
     
    view_box.append(img);
 
    filereader.onload = function() {
      view_box.find('img').attr('src', filereader.result);
      img_del(view_box);
    }
    filereader.readAsDataURL(fileprop);
  });
   
  function img_del(target){
    target.find("a.img_del").on('click',function(){
      var self = $(this),
          parentBox = self.parent().parent().parent();
      if(window.confirm('画像を削除します。\nよろしいですか？')){
        setTimeout(function(){
          parentBox.find('input[type=file]').val('');
          parentBox.find('.img_view').remove();
        } , 0);
      }
      return false;
    });
  }
});

$(function(){
  $('.back-to-item').hover(function(){
    $(this).text('商品詳細画面へ戻る').css('background-color','red')
  },function(){
    $(this).text('編集が完了しました').css('background-color','rgb(60,202,206)')}
)});

$(function(){
  $('.back-to-root').hover(function(){
    $(this).text('トップページへ戻る').css('background-color','blue')
  },function(){
    $(this).text('商品を削除しました').css('background-color','rgb(60,202,206)')}
)});

$(function(){
  $('.back-to-root-form-category').hover(function(){
    $(this).text('トップページへ戻る').css('background-color','blue')
  },function(){
    $(this).text('該当する商品がありません').css('background-color','rgb(60,202,206)')}
)});




