$(function(){
  //画像が選択されたらメソッドが発火！
  $('.avatar_file_field').on("change", function(){
    if ( $('.avatar_file_field')[0].value === "" ) {
      //画像が選択されなければSendボタンはdisableのまま
      $(".avatar-btn")[0].disabled = true;
    }else{
      //画像が選択されればSendボタンを押下可能に変更
      $(".avatar-btn")[0].disabled = false;
    }
  })
});

