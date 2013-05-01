class UserMailer < ActionMailer::Base
  default from: "kareem@getuserwise.com"

  # def order_confirmation_email(consumer)
  #   @consumer = consumer
  #   mail(:to => consumer.email, :subject => "Order Confirmation")
  # end

  # def signup_confirmation_email(user)
  #   @user = user
  #   mail(:to => user.email, :subject => "Sign-up Confirmation")
  # end

  def auction_winner_email(auction)
    @winner = auction.highest_bidder
    mail(:to => @winner.email, :subject => "You've Won!")
  end


end
