// 画像の削除処理
// 削除ボタンをクリックしたとき、処理が動く。
$(document).on('click','.image-preview_btn_delete',function(){
  var append_input = $(`<li class="input"><label class="upload-label"><div class="upload-label__text">ファイルをアップロード<div class="input-area"><i class="fas fa fa-camera image-icon"><input class="hidden image_upload" type="file"></div></div></label></li>`)
  $ul = $('#previews')
  $lis = $ul.find('.image-preview');
  $input = $ul.find('.input');
  $ul = $('#previews')
  $li = $(this).parents('.image-preview');


  //"li"ごと削除して、previewとinputを削除させる。
  $li.remove();

  // inputボタンのサイズを更新する、または追加させる
  // まずはプレビューの数を数える。
  $lis = $ul.find('.image-preview');
  $label = $ul.find('.input');
  if($lis.length < 4 ){
    // inputのサイズを変更
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * ${$lis.length}))`
    })
  }
 
  else if($lis.length == 4 ){
    $ul.append(append_input) // 4個の時だけ、新しいinputを追加してやる
    $('#previews li:last-child').css({
      'width': `calc(100% - (20% * (${$lis.length} - 5 )))`
    })
  }
});
