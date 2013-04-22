class ChangeColumnUserIdInShippingTable < ActiveRecord::Migration
  def change
    rename_column :shipping_addresses, :user_id, :consumer_id
  end
end
