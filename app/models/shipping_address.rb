class ShippingAddress < ActiveRecord::Base
  attr_accessible :street, :city, :state, :zipcode, :order_id

  belongs_to :order
  validates_presence_of :street, :city, :state, :zipcode
end
