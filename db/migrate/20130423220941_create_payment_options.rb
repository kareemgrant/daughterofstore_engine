class CreatePaymentOptions < ActiveRecord::Migration
  def change
    create_table :payment_options do |t|
      t.references :auction
      t.string :type

      t.timestamps
    end
    add_index :payment_options, :auction_id
  end
end
