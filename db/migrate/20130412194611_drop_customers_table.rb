class DropCustomersTable < ActiveRecord::Migration
  def up
    drop_table :customers
  end

  def down
    add_table :customer
  end
end
