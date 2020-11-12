$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChidrenBox(insertHTML){
    console.log("bbbb")
    var childSelectHtml = '';
    childSelectHtml = `<div class='category__styleSelect__selectarea_listen' id= 'children_wrapper'>
                        <div class='category__styleSelect__selectarea__listen__added'>
                          <select class="category__styleSelect__selectarea__listen__added__box" id="child_category" name="">
                            <option value="---" data-category="---">---</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('.category__styleSelect').append(childSelectHtml);
  }

  function appendGrandchidrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='category__styleSelect__selectarea__listen' id= 'grandchildren_wrapper'>
                              <div class='category__styleSelect__selectarea__listen__added'>
                                <select class="category__styleSelect__selectarea__listen__added__box" id="grandchild_category" name="product[category_id]">
                                  <option value="---" data-category="---">---</option>
                                  ${insertHTML}
                                </select>
                              </div>
                            </div>`;
    $('.category__styleSelect').append(grandchildSelectHtml);
  }

  $('#parent_category').on('change', function(){
    var parent_category_id = document.getElementById
    ('parent_category').value; 
    console.log(parent_category_id)
    if (parent_category_id != "---"){ 
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_id: parent_category_id },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); 
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }
    else{
      $('#children_wrapper').remove(); 
      $('#grandchildren_wrapper').remove();
    }
  });

  $('.category__styleSelect').on('change', '#child_category', function() {
    var child_category_id = document.getElementById
    ('child_category').value;
    if (child_category_id != "---"){ 
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: child_category_id },
        dataType: 'json'
      })
      .done(function(grandchildren){
        $('#grandchildren_wrapper').remove(); 
        var insertHTML = '';
        grandchildren.forEach(function(grandchild){
          insertHTML += appendOption(grandchild);
        });
        appendGrandchidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }
    else{
      $('#children_wrapper').remove(); 
      $('#grandchildren_wrapper').remove();
    }
  });
})