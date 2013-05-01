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

  def signup_new_user
    @page.fill_in "Full Name", with: "Bruce Banner"
    @page.fill_in "Email", with: "hulk@example.com"
    @page.fill_in "user_display_name", with: "hulk"
    @page.fill_in "user_password", with: "password"
    @page.fill_in "user_password_confirmation", with: "password"
    @page.click_button 'Register'
  end

  def signup_new_user_with_valid_cc
    @page.fill_in "Full Name", with: "Bruce Banner"
    @page.fill_in "Email", with: "hulk@example.com"
    @page.fill_in "user_display_name", with: "hulk"
    @page.fill_in "user_password", with: "password"
    @page.fill_in "user_password_confirmation", with: "password"
    @page.fill_in 'user_card_number', :with => '4242 4242 4242 4242'
    @page.fill_in('user_card_code', :with => '123')
    @page.select('2017', :from => 'date_card_year')
    @page.click_button 'Register'
  end

end
