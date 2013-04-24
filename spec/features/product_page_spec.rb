require 'spec_helper'

# describe "Product Page" do

#   let!(:store) { Store.where(name:             "store1",
#                              path:             "storeuno",
#                              description:      "somedescription").first_or_create do |store|
#        store.update_attribute(:status, 'online')
#      end
#   }

#   let!(:auction) { Auction.create(store_id: store.id,
#                                   duration: 3,
#                                   starting_bid: 0,
#                                   shipping_options: 'International',
#                                   active: true) }

#   let!(:product){Product.create title:            "product1",
#                                  description:      "somedescription",
#                                  price_in_dollars: 8.99,
#                                  auction_id:         auction.id }


#   context "Given a user visits a product page" do

#      before do
#        visit product_path(store.path, product.id)
#        @product_page = ProductPage.new(page)
#      end

#      it "displays the product's title" do
#        expect(@product_page.title).to eq 'Product1'
#      end

#      it "allows a user to place a bid" do
#        expect(@product_page.title).to eq 'Product1'
#        @product_page.place_bid(8.99)

#        expect(page).to have_content "Congrats! You are now the highest bidder."
#        expect(page).to have_content "Current Bid: $8.99"
#        expect(page).to have_content "# of Bids: 1"
#      end
#   end
# end
