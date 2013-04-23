class Bid < ActiveRecord::Base
  attr_accessible :user_id, :auction_id, :amount

  belongs_to :auction
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :auction_id
  validates_presence_of :amount
end
