class CreateStoresTable < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string  :name
      t.string  :path
    end

  end
end
