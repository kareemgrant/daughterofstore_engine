class SetAuctionStatusToDefaultToTrue < ActiveRecord::Migration
  def change
    change_column :auctions, :active, :boolean, default: true
  end
end
