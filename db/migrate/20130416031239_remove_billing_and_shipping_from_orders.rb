class RemoveBillingAndShippingFromOrders < ActiveRecord::Migration
  def change
    remove_index :orders, :name => "index_orders_on_billing_address_id" 
    remove_index :orders, :name => "index_orders_on_shipping_address_id"

    remove_column :orders, :shipping_address_id
    remove_column :orders, :billing_address_id

    add_column :shipping_addresses, :order_id, :integer
    add_index :shipping_addresses, :order_id
    add_column :billing_addresses, :order_id, :integer
    add_index :billing_addresses, :order_id
  end
end
