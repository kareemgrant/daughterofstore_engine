class AuctionPage

  def initialize(page)
    @page = page
  end

  def title
    @page.find(:css, 'h2').text
  end

  def place_bid(amount)
    @page.fill_in 'bid_amount', with: amount
    @page.click_button 'Submit Bid'
  end

  def highest_bid
    @page.find(:css, "#highest_bid").text
  end

  def number_of_bids
    @page.find(:css, "#number_of_bids").text
  end

  def highest_bidder
    @page.find(:css, "#highest_bidder").text
  end

  def login(user)
    @page.visit "/sessions/new"
    @page.fill_in 'sessions_email', with: user.email
    @page.fill_in 'sessions_password', with: user.password
    @page.click_button 'Log In'
  end

end
