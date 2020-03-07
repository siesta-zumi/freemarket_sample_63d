document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      Payjp.setPublicKey("pk_test_af452b6d7d334942691dce27"); //APIの公開鍵をセット
      let btn = document.getElementById("token_submit"); //「登録する」ボタンのJQueryオブジェクトを取得
      btn.addEventListener("click", e => { //btnがクリックされると発火
        e.preventDefault($("#card_number"));
        let card = { //入力値を取得
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        };
        Payjp.createToken(card, (status, response) => { //トークンを作成するメソッド
          if (status === 200) { //通信が成功した時
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );
            document.inputForm.submit();
            alert("カード情報を登録しました。");
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);
