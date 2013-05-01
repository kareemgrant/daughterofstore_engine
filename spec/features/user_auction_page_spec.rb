require 'spec_helper'

describe "User Auction Page:" do

  let!(:store) { Store.where(name:        "store1",
                             path:        "storeuno",
                             description: "somedescription").first_or_create do |store|
       store.update_attribute(:status,    'online')
     end
  }

  let!(:auction) { Auction.create(store_id:         store.id,
                                  expiration_date:  Time.now + 3600,
                                  starting_bid:     0,
                                  shipping_options: 'international',
                                  active:           true)
                 }

  let!(:product) {Product.create title:            "product1",
                                 description:      "somedescription",
                                 auction_id:       auction.id
                  }

  let!(:user) {User.create(full_name: "Professor X",
                           email: "admin@example.com",
                           password: "password")
              }


  context "when an auction exists" do
    it "a user can view it" do
      visit auction_path(auction.id)
      @auction_page = AuctionPage.new(page)
      expect(@auction_page.title).to eq product.title
    end
  end

  context "when a user is logged in" do

    before do
      @auction_page = AuctionPage.new(page)
      @auction_page.login(user)
      visit auction_path(auction.id)
    end

    it "allows a user to place a bid" do
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


  context "given the highest bidder visits the auction page" do

    before do
      @auction_page = AuctionPage.new(page)
      @auction_page.login(user)
      visit auction_path(auction.id)
    end

    it "displays the badge 'You are the highest bidder'" do
      @auction_page.place_bid(7.99)
      expect(@auction_page.highest_bidder).to eq "Highest Bidder"
    end
  end

  describe "non logged-in user attempts to submit a bid" do

    before do
      @user = create(:user)
      @product = create(:product)
    end


    context "when user is already registered" do

      before do
        visit auction_path(auction.id)
        @auction_page = AuctionPage.new(page)
        @auction_page.place_bid(8)
      end

      context "user does not have valid credit card on file" do

        it "logs in and is redirected to profile page to add cc and then is redirected back to bid page" do
          expect(current_path).to eq login_path
          @auction_page.login(@user)
          expect(current_path).to eq profile_path

          click_link ('Update Your Profile')
          click_link ('Add Credit Card')

          find("#credit_number").fill_in 'credit_number', :with => '4242 4242 4242 4242'
          fill_in('user_card_code', :with => '123')
          page.select('2017', :from => 'date_card_year')
          click_button('Update Profile')

          expect(current_path).to eq auction_path(@product.auction.id)
        end

      end
    end
  end

end
