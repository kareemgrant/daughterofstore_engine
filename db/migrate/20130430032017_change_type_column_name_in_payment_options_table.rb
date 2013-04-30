class ChangeTypeColumnNameInPaymentOptionsTable < ActiveRecord::Migration
  def change
    change_table :payment_options do |t|
      t.rename :type, :payment_type
    end
  end
end
