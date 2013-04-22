class CreateOrderEvents < ActiveRecord::Migration
  def change
    create_table :order_events do |t|
      t.string :status
      t.references :order
      t.timestamps
    end
    add_index :order_events, :order_id
  end
end
