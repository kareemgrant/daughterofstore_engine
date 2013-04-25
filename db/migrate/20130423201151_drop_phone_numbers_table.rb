class DropPhoneNumbersTable < ActiveRecord::Migration
 def change
  drop_table :phone_numbers
 end
end
