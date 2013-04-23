require 'spec_helper'

describe 'Bid:' do

  context 'When a bid is created' do
    it 'it is valid if all required attributes are given' do
      bid = Bid.new(user_id: 1, auction_id: 1, amount: 5)
      expect(bid.valid?).to eq true
    end

    it 'it is invalid without a user_id' do
      bid = Bid.new(auction_id: 1, amount: 5)
      expect(bid.valid?).to eq false
    end

    it 'it is invalid without an auction_id' do
      bid = Bid.new(user_id: 1, amount: 5)
      expect(bid.valid?).to eq false
    end

    it 'it is invalid without an amount' do
      bid = Bid.new(user_id: 1, auction_id: 1)
      expect(bid.valid?).to eq false
    end
  end

end
