class Auction < ActiveRecord::Base
  attr_accessible :expiration_date, :active, :starting_bid, :shipping_options, :store_id, :product_attributes

  belongs_to :store
  has_one :product
  has_many :bids
  has_many :payment_options
  accepts_nested_attributes_for :product, :allow_destroy => true

  validates_presence_of :store_id
  validate :future_expiration_date
  validates_presence_of :starting_bid

  def highest_bid
    bid = Bid.where(auction_id: self.id).order('amount DESC').first
    bid ? bid.amount : starting_bid
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

  def self.parse_expiration_date(string_date)
    date = nil
    string_date.split("/").map {|n| n.to_i}.tap do |month, day, year|
      date = DateTime.new(year, month, day, Time.now.hour, Time.now.min, Time.now.sec)
    end
    date
  end

  private

  def future_expiration_date
    errors.add(:base, "Please enter a future expiraton date.") if !expiration_date.future?
  end
end
