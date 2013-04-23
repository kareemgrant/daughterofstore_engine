class ProductPage

  def initialize(page)
    @page = page
  end

  def title
    @page.find(:css, 'h3#product-title').text
  end

  def place_bid(amount)
    @page.fill_in 'bid_amount', with: amount
    @page.click_button 'Bid'
  end
end