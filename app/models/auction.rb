class Auction < ActiveRecord::Base
  attr_accessible :expiration_date, :active, :starting_bid, :shipping_options, :store_id, :product_attributes



  belongs_to :store
  has_one :product
  has_many :bids
  has_many :payment_options
  accepts_nested_attributes_for :product, :allow_destroy => true

  validates_presence_of :store_id
  # validates_presence_of :expiration_date
  validates_presence_of :starting_bid
  validates_presence_of :shipping_options

  def highest_bid
    bid = Bid.where(auction_id: self.id).order('amount DESC').first
    bid ? bid.amount : 0
  end

  def number_of_bids
    Bid.where(auction_id: self.id).size
  end

  def active?
    active
  end

  def store_name
    Store.find_by_id(store_id).name
  end

  def check_status
    update_attributes(active: false) if expiration_date < Time.now.utc
  end

  def highest_bidder
    Bid.find_by_amount(self.highest_bid).user unless bids.empty?
  end
end
