require 'spec_helper'

describe "User Auction Page:" do

  before do
    @user = create(:user)
    @product = create(:product)
    @auction = @product.auction
    @store = @auction.store
    @store.status = "online"
    @store.save
  end

  context "when an auction exists" do
    it "a user can view it" do
      visit auction_path(@auction.id)
      @auction_page = AuctionPage.new(page)
      expect(@auction_page.title).to eq @product.title
    end
  end

  describe "logged-in user attempts to submit bid" do

    context "when a user does not have valid credit card on file" do

      before do
        @auction_page = AuctionPage.new(page)
        @auction_page.login(@user)
        visit auction_path(@auction.id)
        @bid = 8
        @auction_page.place_bid(@bid)
      end

      it "shows message indicating that a valid credit card is needed to submit a bid"  do
        within '.alert' do
          expect(page).to have_content "Oops, a valid credit card is required before you can submit a bid"
          expect(page).to have_link("Edit Your Account", href: edit_profile_path)
        end
      end

      it "user adds their credit card information and is redirected back to auction page" do
        click_link('Edit Your Account')

        expect(current_path).to eq edit_profile_path

        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        fill_in 'user_card_number', :with => '4242 4242 4242 4242'
        fill_in('user_card_code', :with => '123')
        page.select('2017', :from => 'date_card_year')
        click_button('Update Profile')

        expect(current_path).to eq auction_path(@auction.id)

        within '.alert' do
          expect(page).to have_content "Welcome back, your bid is ready to be submitted"
        end

        expect(find_field('bid_amount').value).to eq(@bid.to_s)

      end
    end
  end


  describe "user with valid credit card on file submit a bid" do
      before do
        @user = create(:user_with_valid_cc)
        @auction_page = AuctionPage.new(page)
        @auction_page.login(@user)
        visit auction_path(@auction.id)
      end

    it "user receives a message indicating that their bid cannot be submitted without credit card on file" do
      @auction_page.place_bid(8.99)

      expect(page).to have_content "You are currently the highest bidder!"
      expect(@auction_page.highest_bid).to eq '$8.00'
      expect(@auction_page.number_of_bids).to eq '1'
    end

    it "user receives a message indicating that their bid cannot be submitted without credit card on file" do
      @auction_page.place_bid(8.99)

      expect(page).to have_content "You are currently the highest bidder!"
      expect(@auction_page.highest_bid).to eq '$8.00'
      expect(@auction_page.number_of_bids).to eq '1'
    end

    it "they cannot place a bid lower than the highest bid" do
      @auction_page.place_bid(9)
      @auction_page.place_bid(8)

      expect(page).to have_content "Your bid must be higher than the current bid"
      expect(@auction_page.highest_bid).to eq '$9.00'
      expect(@auction_page.number_of_bids).to eq '1'
    end

    it "displays the badge 'You are the highest bidder'" do
      @auction_page.place_bid(7.99)
      expect(@auction_page.highest_bidder).to eq "Highest Bidder"
    end
  end

  describe "non logged-in user attempts to submit a bid" do

    before do
      @auction = @product.auction
    end


    context "when user is already registered" do

      before do
        visit auction_path(@auction.id)
        @auction_page = AuctionPage.new(page)
        @bid = 8
        @auction_page.place_bid(@bid)
      end

      context "when user does not have valid credit card on file" do

        it "logs in and is redirected to profile page to add cc and then is redirected back to bid page" do
          expect(current_path).to eq login_path
          @auction_page.login(@user)
          expect(current_path).to eq profile_path

          click_link ('Update Your Profile')
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          fill_in 'user_card_number', :with => '4242 4242 4242 4242'
          fill_in('user_card_code', :with => '123')
          page.select('2017', :from => 'date_card_year')
          click_button('Update Profile')

          expect(current_path).to eq auction_path(@auction.id)

          within '.alert' do
            expect(page).to have_content "Welcome back, your bid is ready to be submitted"
          end

          expect(find_field('bid_amount').value).to eq(@bid.to_s)
        end
      end


      context "when user has a valid credit card on file" do

        before do
          @user = create(:user_with_valid_cc)
        end

        it "logs in and is redirected back to auction page to submit a bid" do
          expect(current_path).to eq login_path
          @auction_page.login(@user)
          expect(current_path).to eq auction_path(@auction.id)

          within '.alert' do
            expect(page).to have_content "Welcome back, your bid is ready to be submitted"
          end

          expect(find_field('bid_amount').value).to eq(@bid.to_s)
        end
      end

    end

    context "when user is not already registered with the site" do

      before do
        visit auction_path(@auction.id)
        @auction_page = AuctionPage.new(page)
        @bid = 8
        @auction_page.place_bid(@bid)
      end

      context "user does not have valid credit card on file" do

        it "signs up and is redirected to profile page to add cc and then is redirected back to bid page" do
          expect(current_path).to eq login_path
          click_link "Not registered? Sign up here"
          expect(current_path).to eq signup_path
          @auction_page.signup_new_user
          expect(current_path).to eq profile_path

          click_link ('Update Your Profile')
          fill_in "user_password", with: "password"
          fill_in "user_password_confirmation", with: "password"
          fill_in 'user_card_number', :with => '4242 4242 4242 4242'
          fill_in('user_card_code', :with => '123')
          page.select('2017', :from => 'date_card_year')
          click_button('Update Profile')

          expect(current_path).to eq auction_path(@auction.id)

          within '.alert' do
            expect(page).to have_content "Welcome back, your bid is ready to be submitted"
          end

          expect(find_field('bid_amount').value).to eq(@bid.to_s)
        end
      end

      context "user has a valid credit card on file" do

        it "signs up and is redirected to the auction page to submit their bid" do
          expect(current_path).to eq login_path
          click_link "Not registered? Sign up here"
          expect(current_path).to eq signup_path
          @auction_page.signup_new_user_with_valid_cc
          expect(current_path).to eq auction_path(@auction.id)

          within '.alert' do
            expect(page).to have_content "Welcome back, your bid is ready to be submitted"
          end

          expect(find_field('bid_amount').value).to eq(@bid.to_s)
        end
      end

    end
  end

end
