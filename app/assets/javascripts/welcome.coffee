$ ->
  $(".btn").on "click", ->
    # $(@).toggleClass("btn-danger")
    $(@).toggleClass("btn-primary").toggleClass("btn-danger")


  eat = (foodItem) ->
    console.log "Eating #{foodItem}"

  eat food for food in ["cheese", "toast", "tomatoes"]

  cookie =
    sugar: 100,
    flour: 50,
    calorie_amount: -> @sugar * 4 + @flour * 5

  cookie.calorie_amount()
