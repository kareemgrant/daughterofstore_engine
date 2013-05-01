class DropProductCategoriesTable < ActiveRecord::Migration
  def change
    drop_table :product_categories
  end
end
