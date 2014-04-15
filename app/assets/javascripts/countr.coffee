$ ->
  maxCharacters = 140
  countchars = ->
    count = $('#count')
    characters = $(@).val().length;
    if characters > maxCharacters
      count.addClass('over')
    else
      count.removeClass('over')
    count.text(maxCharacters - characters + ' / ' + maxCharacters)

  $('#micropost_content').bind('keyup keydown click', countchars)