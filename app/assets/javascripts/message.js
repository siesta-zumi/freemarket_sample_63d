$(function(){
    function buildHTML(message){
      var html =
      `<div class="message-index">
        ${message.user_name}さん:
        ${message.message}
      </div>`
      return html;
    };

  $('#item-message').on('submit' , function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    debugger;
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages-area').append(html);
      $('textarea').val('')
      $('#message_btn').attr('disabled', false);
      $('.messages-area').animate({ scrollTop: $('.messages-area')[0].scrollHeight});

    })
    .fail(function(){
      alert("メッセージ送信に失敗しました");
      $('#message_btn').attr('disabled', false);
    })
  });
});
