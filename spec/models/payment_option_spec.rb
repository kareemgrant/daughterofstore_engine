require 'spec_helper'

describe 'Payment Option:' do

  context 'When a payment option is created' do
    it 'it is valid if all required attributes are given' do
      payment_option = PaymentOption.new(auction_id: 1, payment_type: 'credit card')
      expect(payment_option.valid?).to eq true
    end

    it 'it is invalid without a type' do
      payment_option = PaymentOption.new(auction_id: 1)
      expect(payment_option.valid?).to eq false
    end
  end

end
