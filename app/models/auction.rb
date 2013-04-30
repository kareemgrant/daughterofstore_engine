class Auction < ActiveRecord::Base
  attr_accessible :expiration_date,
                  :active,
                  :starting_bid,
                  :shipping_options,
                  :store_id,
                  :product_attributes,
                  :payment_options_attributes

  belongs_to :store
  has_one    :product
  has_many   :bids
  has_many   :payment_options

  accepts_nested_attributes_for :product, :allow_destroy => true
  accepts_nested_attributes_for :payment_options, :allow_destroy => true

  validates_presence_of :store_id
  validates :starting_bid, presence: true, :numericality => { greater_than_or_equal_to: 0 }

  validates :expiration_date, :expires_in_the_future, presence: true

  validates :shipping_options, presence: true,
            inclusion: {in: %w(domestic international none)}


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

  def expiration_window
    12.hours.from_now
  end

  def expires_in_the_future
    if expiration_date.nil?
      errors.add(:expiration_date,"You have specified an incorrect expiration date")
      false
    elsif expiration_date < expiration_window
      errors.add(:expiration_date,"The expiration is too soon. Please specify a date greater than 6 hours from now")
      false
    else
      true
    end
  end

  def expiration_date=(value)
    if value.is_a?(String)
      value = self.class.parse_expiration_date(value) || value
    end
    write_attribute(:expiration_date,value)
  end

  def self.parse_expiration_date(string_date)
    begin
      date = nil
      string_date.split("/").map {|n| n.to_i}.tap do |month, day, year|
        date = DateTime.new(year, month, day, Time.now.hour, Time.now.min, Time.now.sec)
      end
      date.utc
    rescue
      puts 'Expiration date not entered correctly. Format is mm/dd/yyyy.'
    end
  end

  def valid_expiration_date?
    if expiration_date and !expiration_date.future?
      errors.add(:base, 'Expiration dates must be in the future.')
    end
  end
end
