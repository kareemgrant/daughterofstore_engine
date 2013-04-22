class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price_in_dollars, :active, :created_at, :updated_at, :price, :slug,
  :category_ids, :photo, :photo_file_name, :photo_content_type,
  :photo_file_size, :photo_updated_at, :store, :store_id, :photo_url, :created_at, :updated_at, :price, :slug
  # extend FriendlyId
  # friendly_id :title, use: :slugged

  validates_uniqueness_of :title
  validates_presence_of :title, :description, :price_in_dollars, :store_id
  validates :price, :numericality => {:greater_than => 1,
    :message => "price must be greater than zero"}
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :line_items
  belongs_to :store
  has_attached_file :photo #,



  before_destroy :ensure_not_referenced_by_any_line_item

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


  private

  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      true
    else
      errors.add(:base, 'Line Items present')
      false
    end
  end
end
