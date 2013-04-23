class PaymentOption < ActiveRecord::Base
  belongs_to :auction
  # attr_accessible :title, :body
end
