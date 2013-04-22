class Cart < ActiveRecord::Base
  attr_accessible :store_id, :sid
  has_many :line_items, dependent: :destroy
  has_many :products

  belongs_to :store

  validates_presence_of :store_id

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def empty?
    LineItem.find_all_by_cart_id(self.id).empty?
  end

end
