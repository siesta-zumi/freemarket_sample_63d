$(function() {
  function buildHTML(result){
    var html =
      `<option value= ${result.id}>${result.name}</option>`
    return html
  }
  $("#item_category_id").on("change",function(){
    var int = document.getElementById("item_category_id").value;
    if(int == 0){
      $('#child').remove();
      $('#grand-child').remove();
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
        if($('#child').length){
          $('#child').replaceWith(insertHTML);
          $('#grand-child').remove();
        } else {
          $('.child-category').append(insertHTML);
  
        };
      })
      .fail(function() {
      });
    }
    
  });

  
  $(document).on("change","#child",function(){
    var intParent = document.getElementById("item_category_id").value
    var intChild = document.getElementById("child").value
    var int = intParent + '/' + intChild

    if(intChild == 0){
      $('#grand-child').remove();
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
        if($('#grand-child').length){
          $('#grand-child').replaceWith(insertHTML);
        }else{
          $('.grand-child-category').append(insertHTML);
        }
      })
      .fail(function() {
      });
    }
    
  });
})