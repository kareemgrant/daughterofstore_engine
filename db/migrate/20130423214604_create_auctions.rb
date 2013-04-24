class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.references :store
      t.integer :starting_bid
      t.string :shipping_options
      t.integer :duration
      t.boolean :active

      t.timestamps
    end
    add_index :auctions, :store_id
  end
end
