jQuery ->
  $("#credit-card").hide()
  $("#edit-card").show()

  $("#edit-credit-card").hide()
  $("#edit-card-link").show()

  $("#edit-card a").click ->
    $("#edit-card").hide()
    $("#credit-card").show()
    $("#credit_card_number").focus()

  $("#close-card-form a").click ->
    $("#credit-card").hide()
    $("#edit-card").show()

  $("#edit-card-link a").click ->
    $("#edit-card-link").hide()
    $("#edit-credit-card").show()

