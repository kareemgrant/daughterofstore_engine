class AddTenantToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tenant_id, :integer
    add_index :orders, :tenant_id
  end
end
