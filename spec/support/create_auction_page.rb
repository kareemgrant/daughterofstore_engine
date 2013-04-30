class CreateAuctionPage

  def initialize(page)
    @page = page
  end

  def log_in(user)
    @page.visit        "/sessions/new"
    @page.fill_in      'sessions_email', with: user.email
    @page.fill_in      'sessions_password', with: user.password
    @page.click_button 'Log In'
  end

  def create
    @page.click_on 'Start Auction'

    @page.fill_in 'auction_expiration_date', with: '05/25/2013'
    @page.fill_in  'Starting Bid',        with: 8.99

    @page.choose('International')

    @page.fill_in  'Product Title',       with: 'Xtreme Knitter'
    @page.fill_in  'Product Description', with: 'Knitting to the Xtreme!'

    @page.click_button 'Start Auction'
  end
end