class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :email
      t.string :display_name
      t.string :password_digest

      t.timestamps
    end
  end
end
