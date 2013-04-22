class AddSessionIdToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :sid, :string
    add_index :carts, :sid
  end
end
