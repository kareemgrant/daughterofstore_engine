class ChangeReferenceFromTenantsToStoresInOrders < ActiveRecord::Migration
  
  def change
    remove_index :orders, :name => "index_orders_on_tenant_id"
    remove_column :orders, :tenant_id
    add_column :orders, :store_id, :integer
    add_index :orders, :store_id
  end
end
