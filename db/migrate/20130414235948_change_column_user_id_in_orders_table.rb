class ChangeColumnUserIdInOrdersTable < ActiveRecord::Migration
  
  def change
    rename_column :orders, :user_id, :consumer_id
  end
  
end
