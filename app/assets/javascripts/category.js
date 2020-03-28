$(function() {
  function buildHTML(result){
    var html =
      `<option value= ${result.id}>${result.name}</option>`
    return html
  }
  $("#item_category_id").on("change",function(){
    var int = document.getElementById("item_category_id").value;
    $.ajax({
      url: 'search',
      type: 'GET',
      dataType: 'json',
      data: {id: int}
    })
    .done(function(children) {
      var insertHTML = `<select name="child" id="child">
                        <option value=0>選択して下さい</option>`;
      $.each(children, function(i, child) {
        insertHTML += buildHTML(child)
      });
      insertHTML += `</select>`
      $('.child-category').append(insertHTML);
    })
    .fail(function() {
    });
  });

  $(document).on("change","#child",function(){
   
    var intParent = document.getElementById("item_category_id").value
    var intChild = document.getElementById("child").value
    var int = intParent + '/' + intChild
    $.ajax({
      url: 'search',
      type: 'GET',
      dataType: 'json',
      data: {id: int}
    })
    .done(function(grandchild) {
      var insertHTML = `<select name="item[category_id]" id="child_category">
                        <option value=0>---</option>`;
      $.each(grandchild, function(i, child) {
        insertHTML += buildHTML(child)
      });
      insertHTML += `</select>`
      $('.grand-child-category').append(insertHTML);
    })
    .fail(function() {
    });
  });
})