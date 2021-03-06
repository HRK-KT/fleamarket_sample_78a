window.addEventListener('DOMContentLoaded', function(){

  //"payment_card_submit-button"ボタンが押されたら取得
  Payjp.setPublicKey('pk_test_fbb7b5276b50edbd22ac86f4');
  let submit = document.getElementById("payment_card_submit-button");

    submit.addEventListener('click', function(e){ //ボタンが押されたらトークン作成開始
      e.preventDefault(); //ボタンを1度無効化

      let card = { //入力されたカード情報を取得(id名の確認)
          number: document.getElementById("payment_card_no").value,
          exp_month: document.getElementById("payment_card_month").value,
          exp_year: document.getElementById("payment_card_year").value,
          cvc: document.getElementById("payment_card_cvc").value
    };

    Payjp.createToken(card, function(status, response) {  // トークンを生成
      if (status === 200) { //データを自サーバにpostしないようにremoveAttr("name")で削除
        $("#payment_card_no").removeAttr("name");
        $("#payment_card_month").removeAttr("name");
        $("#payment_card_year").removeAttr("name");
        $("#payment_card_cvc").removeAttr("name"); 
        $("#charge-form").append(
          $('<input type="hidden" name="payjp_token">').val(response.id)
        ); //取得したトークンを送信できる状態
        document.inputForm.submit();
        alert("登録が完了しました"); //正常処理完了確認用
      } else {
        alert("カード情報が正しくありません。"); //エラー確認用
      }
    });
  });
});