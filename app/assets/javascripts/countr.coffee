$ ->
  maxCharacters = 140
  countchars = ->
    count = $('#count')
    characters = $(@).val().length;
    if characters > maxCharacters
      count.addClass('over')
    else
      count.removeClass('over')
    count.html(maxCharacters - characters + '/ ' + maxCharacters)

  $('textarea').bind('keyup keydown click', countchars)