require 'spec_helper'

describe "User Auction Page:" do

  let!(:store) { Store.where(name:             "store1",
                             path:             "storeuno",
                             description:      "somedescription").first_or_create do |store|
       store.update_attribute(:status, 'online')
     end
  }

  let!(:auction) { Auction.create(store_id: store.id,
                                  duration: 3,
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

    context "and has a validated credit card" do
      it "it allows a user to place a bid" do
        @auction_page.place_bid(8.99)

        expect(page).to have_content "You are currently the highest bidder!"
        expect(@auction_page.highest_bid).to eq '8'
        expect(page).to have_content "# of Bids: 1"
      end

      it "they cannot place a bid lower than the highest bid" do
        @auction_page.place_bid(9)
        @auction_page.place_bid(8)
        expect(page).to have_content "Your bid must be higher than the current bid"
        expect(@auction_page.highest_bid).to eq 9
      end
    end

    context "but does not have a validated credit card" do
      xit "it prompts the user to validate a credit card on attempt to bid" do

      end
    end
  end

  context "when a user is not logged in" do
    xit "it prompts the user to login when they attempt to bid" do

    end
  end

end
