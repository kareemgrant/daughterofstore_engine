class AddEndEarlyColumnToAuctions < ActiveRecord::Migration
  def change
    add_column :auctions, :end_early, :boolean
  end
end
