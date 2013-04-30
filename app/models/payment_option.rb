class PaymentOption < ActiveRecord::Base
  attr_accessible :auction_id, :payment_type

  belongs_to :auction

  validates_presence_of :payment_type
end
