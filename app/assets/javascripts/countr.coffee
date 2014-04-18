$(document).on 'keyup keydown', '#micropost_content',  ->
  maxCharacters = 140
  count = $('#count')
  characters = $(@).val().length;
  if characters >= maxCharacters - 10
    count.addClass('over')
  else
    count.removeClass('over')
  count.text(maxCharacters - characters + ' / ' + maxCharacters)

