class AddStoreIdToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :store_id, :integer
    add_index :carts, :store_id
  end
end
