class PaymentOption < ActiveRecord::Base
  attr_accessible :auction_id, :type

  belongs_to :auction

  validates_presence_of :auction_id
  validates_presence_of :type
end
