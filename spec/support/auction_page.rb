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

end