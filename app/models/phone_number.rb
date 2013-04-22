class PhoneNumber < ActiveRecord::Base
  attr_accessible :phone, :user_id, :receive_sms
  belongs_to :user
end
