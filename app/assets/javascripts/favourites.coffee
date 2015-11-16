$ ->
  capitalize = (word) ->
    firstLetterCap = word.charAt(0).toUpperCase()
    firstLetterCap + word.slice(1)

  $("#input").on "keyup", ->
    array = $(@).val().split(" ")
    array = array.map (word) -> capitalize(word)
    $("#output").html(array.join(" "))
