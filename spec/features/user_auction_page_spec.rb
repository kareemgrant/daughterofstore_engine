require 'spec_helper'

describe "User Auction Page:" do

  let!(:store) { Store.where(name:             "store1",
                             path:             "storeuno",
                             description:      "somedescription").first_or_create do |store|
       store.update_attribute(:status, 'online')
     end
  }

  let!(:auction) { Auction.create(store_id: store.id,
                                  expiration_date: Time.now + 3600,
                                  starting_bid: 0,
                                  shipping_options: 'International',
                                  active: true) }

  let!(:product) {Product.create title:            "product1",
                                 description:      "somedescription",
                                 price_in_dollars: 8.99,
                                 auction_id:         auction.id }

  let!(:user) {User.create(full_name: "Professor X", email: "admin@example.com", password: "password")}


  context "when an auction exists" do
    it "a user can view it" do
      visit auction_path(auction.id)
      @auction_page = AuctionPage.new(page)
      expect(@auction_page.title).to eq product.title
    end
  end

  context "when a user is logged in" do

    before do
      visit '/sessions/new'
      fill_in 'sessions_email', with: user.email
      fill_in 'sessions_password', with: user.password
      click_button 'Log In'
      visit auction_path(auction.id)
      @auction_page = AuctionPage.new(page)
    end

    it "it allows a user to place a bid" do
      @auction_page.place_bid(8.99)

      expect(page).to have_content "You are currently the highest bidder!"
      expect(@auction_page.highest_bid).to eq '8'
      expect(@auction_page.number_of_bids).to eq '1'
    end

    it "they cannot place a bid lower than the highest bid" do
      @auction_page.place_bid(9)
      @auction_page.place_bid(8)

      expect(page).to have_content "Your bid must be higher than the current bid"
      expect(@auction_page.highest_bid).to eq '9'
      expect(@auction_page.number_of_bids).to eq '1'
    end
  end

  context "when a user is not logged in" do
    it "it prompts the user to login when they attempt to bid and redirects back to the auction page" do
      visit auction_path(auction.id)
      @auction_page = AuctionPage.new(page)
      @auction_page.place_bid(8)
      expect(current_path).to eq login_path
      fill_in('sessions_email', with: 'admin@example.com')
      fill_in('sessions_password', with: 'password')
      click_button 'Log In'
      expect(current_path).to eq auction_path(auction.id)
    end
  end

  context "given the highest bidder visits the auction page" do
    before do
      visit '/sessions/new'
      fill_in 'sessions_email', with: user.email
      fill_in 'sessions_password', with: user.password
      click_button 'Log In'
      visit auction_path(auction.id)
      @auction_page = AuctionPage.new(page)
    end

    it "displays the badge 'You are the highest bidder'" do
      @auction_page.place_bid(7.99)

      expect(@auction_page.highest_bidder).to eq "Highest Bidder"
    end
  end

end
