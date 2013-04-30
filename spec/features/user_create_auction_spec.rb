require 'spec_helper'

describe "Create Auctions" do
  before(:each) do
    @user = User.create(full_name:     "Roger",
                        email:         "store@owner.com",
                        password:      "password")

    @store = Store.create(name:        "bikeshop",
                          path:        "bikeshop",
                          description: "somedescription")

    @store.update_attribute(:status, "online")

    UserStoreRole.create!(user_id: @user.id, store_id: @store.id, role: 'admin')

    ApplicationController.any_instance.stub(:current_store).and_return(@store)
  end

  context "given a logged in store owner" do
    it "allows store owner to create an auction" do
      @create_auction = CreateAuctionPage.new(page)
      @create_auction.log_in(@user)


      visit store_admin_path(@store)
      @create_auction.create

      auction = Auction.last
      product = Product.last

      expect(page).to have_content    product.title
      expect(page).to have_content    @store.name
      expect(auction.store_id).to     eq @store.id
      expect(product.auction_id).to   eq auction.id
    end
  end
end