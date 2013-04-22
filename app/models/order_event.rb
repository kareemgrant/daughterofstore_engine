class OrderEvent < ActiveRecord::Base
  belongs_to :order
  attr_accessible :status

  validates_presence_of :order_id
  validates_inclusion_of :status, in: Order::STATUSES

  def self.with_last_status(status)
    order("id desc").group("order_id").having(status: status)
  end
end
