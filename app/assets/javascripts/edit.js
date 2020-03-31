$(function() {
  function buildHTML(result){
    var html =
      `<option value= ${result.id}>${result.name}</option>`
    return html
  }
  
  $("#parent").on("change",function(){
    console.log('AAA');
    var $child = $('#edit-child');
    var $grandChild = $('#edit-grand-child');
    var int = document.getElementById("parent").value;
    
    if(int == 0){
      $child.remove();
      $grandChild.remove();
    }else{
      $.ajax({
        url: '/items/search',
        type: 'GET',
        dataType: 'json',
        data: {id: int}
      })
      .done(function(children) {
        
        var insertHTML = `<select name="child" id="edit-child">
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

  
  $(document).on("change","#edit-child",function(){
    var intParent = document.getElementById("parent").value
    var intChild = document.getElementById("edit-child").value
    var int = intParent + '/' + intChild
    var $grandChild = $('#edit-grand-child');

    if(intChild == 0){
      $grandChild.remove();
    }else{
      $.ajax({
        url: '/items/search',
        type: 'GET',
        dataType: 'json',
        data: {id: int}
      })
      .done(function(grandchild) {
        var insertHTML = `<select name="item[category_id]" id="edit-grand-child">
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