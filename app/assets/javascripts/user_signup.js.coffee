jQuery ->
  $("#edit-card a").click ->
    $("#edit-card").hide()
    $("#credit-card").show()
    $("#credit_card_number").focus()

  $("#close-card-form a").click ->
    $("#credit-card").hide()
    $("#edit-card").show()

  $("#edit-card-link a").click ->
    console.log "clicked"
    $("#edit-card-link").hide()
    $("#edit-credit-card").show()

signup =
  setupForm: ->
    $("new_user").submit ->
      alert("clicked button")
      form = this
      $("#user_submit").attr("disabled", true)
      $("#credit-card input, #credit-card select").attr("name", "")
      $("#credit-card-errors").hide()

      if $('#card_number').val()
        alert("about to processCard")
        signup.processCard()
        false
       else
        alert("card number field is blank, will not processCard")
        true

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, signup.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if (status == 200)
      $("#user_stripe_token").val(response.id)
      $('#new_user')[0].submit()
      form.submit()
     else
      $("#stripe-error-message").text(response.error.message)
      $("#credit-card-errors").show()
      $("#user_submit").attr("disabled", false)

