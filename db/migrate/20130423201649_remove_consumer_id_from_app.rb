class RemoveConsumerIdFromApp < ActiveRecord::Migration
  def change
    remove_column :shipping_addresses, :consumer_id
    remove_column :orders, :consumer_id
    remove_column :billing_addresses, :consumer_id
  end
end
