class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :auction
      t.references :user
      t.integer :amount

      t.timestamps
    end
    add_index :bids, :auction_id
    add_index :bids, :user_id
  end
end
