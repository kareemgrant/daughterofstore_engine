class Auction < ActiveRecord::Base
  attr_accessible :expiration_date, :active, :starting_bid, :shipping_options, :store_id

  belongs_to :store
  has_one :product
  has_many :bids
  has_many :payment_options

  validates_presence_of :store_id
  validates_presence_of :expiration_date
  validates_presence_of :active
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

  def time_left
    if self.active?
      humanize((expiration_date - Time.now))
    else
      "Auction has expired"
    end
  end

  def humanize secs
    [[60, "seconds"], [60, "minutes"], [24, "hours"], [1000, "days"]].inject([]) do |s, (count, name)|
    if secs > 0
      secs, n = secs.divmod(count)
      s.unshift "#{n.to_i} #{name}"
    end
    s
  end.join(' ')
end

end
