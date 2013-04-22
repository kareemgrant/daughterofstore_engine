class ChangeReferencesToStoresOnUsers < ActiveRecord::Migration
   def change
    remove_index :users, :name => "index_users_on_tenant_id"
    remove_column :users, :tenant_id
    add_column :users, :store_id, :integer
    add_index :users, :store_id
  end
end
