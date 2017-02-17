$(document).on("turbolinks:load", function() {
  catch_word_answer();
  $('.btn-delete').click(function(){
    $(this).prev().attr('value', 1);
    $(this).parent().hide();
  });

  $('#btn-add').click(function(){
    time = new Date().getTime();

    input = '<input class="answer_content form-control" name=word[answers_attributes][' 
      + time + '][content] />';
    default_checkbox = '<input type="hidden" name="word[answers_attributes]['
      + time + '][is_correct]" value="0">';
    checkbox = '<input class="answer_checkbox" type="checkbox" name="word[answers_attributes][' 
      + time + '][is_correct]" value="1">';
    destroy = '<input type="hidden" name=word[answers_attributes][' 
      + time + '][_destroy] value="0" />';
    btn_delete = '<span class="btn-delete" >Remove</span>'; 
    $('.content').css('padding-left','100px')
    $('.content').append('<div class="answer_word">' + input + default_checkbox 
      + checkbox + destroy + btn_delete + '</div>' + '<br>' + '<br>');

    $('.btn-delete').click(function(){
      $(this).prev().attr('value', 1);
      $(this).parent().hide();
    });
  });

  function catch_word_answer(){
    $('.btn-submit-word').click(function(event){
      event.preventDefault();
      number_answer = $('.answer_word:visible').length
      // if($('.answer_content[value=""]').length != 0)
      //   alert('answer content not blank');
      // else if (number_answer < 2) 
      //   alert('not enought answer');
      // else {
      //   number_correct = $('.answer_checkbox:checked:visible').length;
      //   if(number_correct != 1)
      //     alert('error correct answer');
      //   else
      $('form').submit();
      // }
    });
  }
});
