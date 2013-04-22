class CreateUserStoreRoles < ActiveRecord::Migration
  def change
    create_table :user_store_roles do |t|
      t.integer :user_id
      t.integer :store_id
      t.string :role

      t.timestamps
    end

    add_index :user_store_roles, [:store_id, :user_id], unique: true
    add_index :user_store_roles, :user_id
  end
end
