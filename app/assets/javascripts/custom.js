$(document).on("turbolinks:load", function() {
  $('#btn-add').click(function(){
    time = new Date().getTime();

    input = '<input class: "form-control" name=word[answers_attributes][' 
      + time + '][content] />';
    default_checkbox = '<input type="hidden" name="word[answers_attributes]['
      + time + '][is_correct]" value="0">';
    checkbox = '<input type="checkbox" name="word[answers_attributes][' 
      + time + '][is_correct]" value="1">';
    destroy = '<input type="hidden" name=word[answers_attributes][' 
      + time + '][_destroy] value="0" />';
    btn_delete = '<span class="btn-delete" >Remove</span>'; 
    $('.content').css('padding-left','100px')
    $('.content').append('<div>' + input + default_checkbox 
      + checkbox + destroy + btn_delete + '</div>' + '<br>' + '<br>');

    $('.btn-delete').click(function(){
      $(this).prev().attr('value', 1);
      $(this).parent().hide();
    });
  });
});
