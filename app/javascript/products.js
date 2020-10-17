// 画像の複数投稿およびプレビュー処理

$(function(){

  // プレビュー機能
  $(document).on('change', '.image_upload', function(e){
    // $liに追加するためのプレビュー画面のHTML。横長でないとバグる
    var preview = $('<div class="image-preview__wapper"><img class="preview"></div><div class="image-preview_btn"><div class="image-preview_btn_delete">削除</div></div>'); 
    //次の画像を読み込むためのinput。 
    var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text">ファイルをアップロード<div class="input-area"><i class="fas fa fa-camera image-icon"></i><input class="hidden image_upload" type="file"></div></div></label></li>`)

    // 変数ulに#previewsの要素を取得
    $ul = $('#previews')
    // 変数ulに#previewsの要素を取得
    // ここのthisは画像選択を行ったinput要素(image.file_field :image, class: "hidden image_upload")になる
    // このinputの先祖のli要素を取得
    $li = $(this).parents('li');
     // このinputの先祖の.upload-label要素を取得
    $label = $(this).parents('.upload-label');
  
    //inputに画像を読み込んだら、"プレビューの追加"と"新しいli追加"処理が動く
    // $('.image_upload').on('change', function (e) {
      //inputで選択した画像を読み込む
      var reader = new FileReader();

      // プレビューに追加させるために、inputから画像ファイルを読み込む。
      reader.readAsDataURL(e.target.files[0]);

      //画像ファイルが読み込んだら、処理が実行される。 
      reader.onload = function(e){
        //previewをappendで追加する前に、プレビューできるようにinputで選択した画像を<img>に'src'で付与させる
        // つまり、<img>タグに画像を追加させる
        $(preview).find('.preview').attr('src', e.target.result);
      }

      //inputの画像を付与した,previewを$liに追加。
      $li.append(preview);

      //プレビュー完了後は、inputを非表示にさせる。これによりプレビューだけが残る。
      $label.css('display','none'); // inputを非表示
      $li.removeClass('input');     // inputのクラスはjQueryで数を数える時に邪魔なので除去
      $li.addClass('image-preview'); // inputのクラスからプレビュー用のクラスに変更した
      $lis = $ul.find('.image-preview'); // クラス変更が完了したところで、プレビューの数を数える。 
      $('#previews li').css({
        'width': `120px`
      })

      //"ul"に新しい"li(inputボタン)"を追加させる。
      if($lis.length <= 4 ){
        $ul.append(append_input)
        // 入力枠を狭める処理
        $('#previews li:last-child').css({
          'width': `calc(100% - (20% * ${$lis.length}))`
        })
      }

      // 全てのimage_uploadを取得する
      $inputs = $ul.find('.image_upload');

      //inputの最後の"data-image"を取得して、input nameの番号を更新させてる。
      // これをしないと、それぞれのinputの区別ができず、最後の1枚しかDBに保存されません。
      // 全部のプレビューの番号を更新することで、プレビューを削除して、新しく追加しても番号が1,2,3,4,5,6と綺麗に揃う。だから全部の番号を更新させる
      $inputs.each( function( num, input ){
        //nameの番号を更新するために、現在の番号を除去
        $(input).removeAttr('name');
        $(input).attr({
          // name:"product[images_attributes][" + num + "][image]",
          name:`product[images_attributes][${num}][image]`,
          id:"product_images_attributes_" + num + "_image"
        });
      });
  })
});

// エラーがでたときにインプットボタンを１つに戻す（複数投稿しちゃうとその数だけボタンが残っちゃうので）
$(window).on('load', function () {
  var image_files = document.getElementsByClassName('image_file_box');
  const imgLength = image_files.length;
  
  for (var i = (imgLength - 1) ; i >= 1 ; i--) {
    image_files[i].remove();
  }
});
