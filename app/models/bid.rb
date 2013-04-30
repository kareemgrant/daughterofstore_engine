class Bid < ActiveRecord::Base
  attr_accessible :user_id, :auction_id, :amount

  belongs_to :auction
  belongs_to :user

  validate :validate_bid_amount
  validate :validate_active_auction
  validates_presence_of :user_id
  validates_presence_of :auction_id
  validates_presence_of :amount

  def validate_bid_amount
    self.errors.add(:base, "Bid amount too low") if (self.auction.nil? || (self.amount <= self.auction.highest_bid if amount))
  end

  def validate_active_auction
    self.auction.check_status if self.auction
    self.errors.add(:base, "Auction has expired. Bidding closed.") if (self.auction.nil? || self.auction.active? == false)
  end
end


