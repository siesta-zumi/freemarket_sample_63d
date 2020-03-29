$(function() {
  function buildHTML(result){
    var html =
      `<option value= ${result.id}>${result.name}</option>`
    return html
  }
  
  $("#item_category_id").on("change",function(){
    var $child = $('#child');
    var $grandChild = $('#grand-child');
    var int = document.getElementById("item_category_id").value;
    if(int == 0){
      $child.remove();
      $grandChild.remove();
    }else{
      $.ajax({
        url: 'search',
        type: 'GET',
        dataType: 'json',
        data: {id: int}
      })
      .done(function(children) {
        var insertHTML = `<select name="child" id="child">
                          <option value=0>---</option>`;
        $.each(children, function(i, child) {
          insertHTML += buildHTML(child)
        });
        insertHTML += `</select>`
        if($child.length){
          $child.replaceWith(insertHTML);
          $grandChild.remove();
        } else {
          $('.child-category').append(insertHTML);
  
        };
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      });
    }
    
  });

  
  $(document).on("change","#child",function(){
    var intParent = document.getElementById("item_category_id").value
    var intChild = document.getElementById("child").value
    var int = intParent + '/' + intChild
    var $grandChild = $('#grand-child');

    if(intChild == 0){
      $grandChild.remove();
    }else{
      $.ajax({
        url: 'search',
        type: 'GET',
        dataType: 'json',
        data: {id: int}
      })
      .done(function(grandchild) {
        var insertHTML = `<select name="item[category_id]" id="grand-child">
                          <option value=0>---</option>`;
        $.each(grandchild, function(i, child) {
          insertHTML += buildHTML(child)
        });
        insertHTML += `</select>`
        if($grandChild.length){
          $grandChild.replaceWith(insertHTML);
        }else{
          $('.grand-child-category').append(insertHTML);
        }
      })
      .fail(function() {
        alert('カテゴリー取得に失敗しました');
      });
    }
    
  });
})