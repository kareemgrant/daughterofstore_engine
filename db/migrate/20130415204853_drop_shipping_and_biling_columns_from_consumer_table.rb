class DropShippingAndBilingColumnsFromConsumerTable < ActiveRecord::Migration
  def change
    remove_column :consumers, :shipping_address_id
    remove_column :consumers, :billing_address_id
  end
end
