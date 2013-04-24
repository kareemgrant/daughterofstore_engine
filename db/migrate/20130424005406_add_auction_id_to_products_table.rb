class AddAuctionIdToProductsTable < ActiveRecord::Migration
  def change
    add_column :products, :auction_id, :integer
  end
end
