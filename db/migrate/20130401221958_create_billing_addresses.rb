class CreateBillingAddresses < ActiveRecord::Migration
  def change
    create_table :billing_addresses do |t|
      t.references :user
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.timestamps

    end
  end
end
