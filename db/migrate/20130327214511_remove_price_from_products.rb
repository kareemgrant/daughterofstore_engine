class RemovePriceFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :price
    add_column :products, :price, :integer, :null => false
  end
end
