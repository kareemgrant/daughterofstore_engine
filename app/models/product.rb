class Product < ActiveRecord::Base
  attr_accessible :title,
                  :description,
                  :price_in_dollars,
                  :active,
                  :created_at,
                  :updated_at,
                  :price,
                  :slug,
                  :category_ids,
                  :photo_url,
                  :auction_id


    has_attached_file :photo,
                      styles: { large: '600x600>', thumb: '100x100>'},
                      default_url: 'http://placehold.it/300/300'

  validates_uniqueness_of :title
  validates_presence_of :title, :description, :price_in_dollars, :auction_id
  validates :price, :numericality => {:greater_than => 1,
  :message => "price must be greater than zero"}

  belongs_to :auction
  has_many :product_categories
  has_many :categories, through: :product_categories

  def status
    active ? "active" : "retired"
  end

  def to_s
    title
  end

  def price_in_dollars
    price.to_f / 100 if price
  end

  def price_in_dollars=(dollars)
    self.price = dollars.to_f * 100.0
  end

  def categories_list
    self.categories.join(", ")
  end

end
