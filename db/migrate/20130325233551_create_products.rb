class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title, :null => false
      t.text :description, :null => false
      t.decimal :price, :null => false, :scale => 2

      t.timestamps
    end
  end
end
