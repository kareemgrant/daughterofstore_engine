class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :total_price, :null => false
      t.string :status, :null => false, :default => "pending"
      t.references :user, :null => false

      t.timestamps
    end
    add_index :users, :id
  end
end
