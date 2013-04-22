class ChangeColumnUserIdInBillingTable < ActiveRecord::Migration
  def change
    rename_column :billing_addresses, :user_id, :consumer_id
  end
end
