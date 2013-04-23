class Order < ActiveRecord::Base
  attr_accessible :total_price, :stripe_card_token, :store, :email, :store_id, :billing_address_attributes, :shipping_address_attributes, :random_order_id
  attr_accessor :stripe_card_token, :email, :card_number, :card_month, :card_code, :card_year

  has_many :events, class_name: "OrderEvent"
  has_one :shipping_address
  has_one :billing_address

  belongs_to :store
  validates_presence_of :total_price

  accepts_nested_attributes_for :billing_address, :shipping_address

  # Needs Rewrite
  def self.create_from_cart(cart, order_details, consumer)
    order = new(order_details)
    order.add_line_items(cart)
    order.total_price = order.total_price_from_cart(cart)
    order.consumer = consumer

    order.save_with_payment
    order
  end

  # Needs Rewrite
  def save_with_payment
    if valid?
      Stripe::Charge.create(amount: self.total_price * 100, currency: "usd",
        card: stripe_card_token, description: self.consumer.email)
      save!
      self.paid
    end
  rescue Stripe::InvalidRequestError => e
    logger.error "Stripe error while creating customer: #{e.message}"
    errors.add :base, "There was a problem with your credit card."
    false
  end

  def self.pending
    Order.all.select{|o| o.pending?}
  end

  def self.cancelled
    Order.all.select{|o| o.cancelled?}
  end

  def self.paid
    Order.all.select{|o| o.paid?}
  end

  def self.shipped
    Order.all.select{|o| o.shipped?}
  end

  def self.returned
    Order.all.select{|o| o.returned?}
  end

  def total_price_from_cart(cart)
    self.total_price = cart.total_price
    total_price
  end

  STATUSES = %w[pending cancelled paid shipped returned]
  delegate :pending?, :cancelled?, :paid?, :shipped?, :returned?,
  to: :current_status

  def self.pending_orders
    joins(:events).merge OrderEvent.with_last_status("pending")
  end

  def current_status
    (events.last.try(:status) || STATUSES.first).inquiry
  end

  def paid
    events.create! status: "paid" if pending?
  end

  def cancel
    events.create! status: "cancelled" if pending?
  end

  def return
    events.create! status: "returned" if shipped?
  end

  def ship
    events.create! status: "shipped" if paid?
  end

end
