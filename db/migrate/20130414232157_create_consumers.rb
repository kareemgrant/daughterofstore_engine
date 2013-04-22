class CreateConsumers < ActiveRecord::Migration
  def change
    create_table :consumers do |t|
      t.string :email
      t.integer :billing_address_id
      t.integer :shipping_address_id
      t.integer :user_id

      t.timestamps
    end
  end
end
