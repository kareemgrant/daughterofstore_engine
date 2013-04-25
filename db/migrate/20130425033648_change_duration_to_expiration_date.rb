class ChangeDurationToExpirationDate < ActiveRecord::Migration
  def change
    remove_column :auctions, :duration
    add_column    :auctions, :expiration_date, :datetime
  end
end
