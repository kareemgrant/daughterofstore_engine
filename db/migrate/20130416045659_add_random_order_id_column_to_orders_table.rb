class AddRandomOrderIdColumnToOrdersTable < ActiveRecord::Migration
  def change
    add_column :orders, :random_order_id, :string
  end
end
