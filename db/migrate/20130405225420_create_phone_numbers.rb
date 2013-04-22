class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.string :phone, :null => true
      t.boolean :receive_sms
      t.references :user
      t.timestamps
    end
  end
end
