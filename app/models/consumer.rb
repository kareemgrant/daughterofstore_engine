class Consumer < ActiveRecord::Base
  attr_accessible :billing_address_id, :email, :shipping_address_id, :user_id

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :orders
  belongs_to :user

  
end
