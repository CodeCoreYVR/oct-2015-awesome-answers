# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  a = 1

  b = 5 if a > 1

  console.log a

  capitalize = (word) ->
    firstLetterCap = word.charAt(0).toUpperCase()
    firstLetterCap + word.slice(1)

  console.log capitalize("tam")

  $("img").on "click", ->
    $(@).hide()
