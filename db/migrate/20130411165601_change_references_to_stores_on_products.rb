class ChangeReferencesToStoresOnProducts < ActiveRecord::Migration
  def change
    remove_index :products, :name => "index_products_on_tenant_id"
    remove_column :products, :tenant_id
    add_column :products, :store_id, :integer
    add_index :products, :store_id
  end
end
