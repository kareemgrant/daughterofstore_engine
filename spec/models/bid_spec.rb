require 'spec_helper'


describe 'Bid:' do

  before :each do
    @auction = Auction.create(store_id: 1,
                               expiration_date: Time.new(2014, 10, 7),
                               starting_bid: 0,
                               shipping_options: 'International',
                               active: true)
  end

  context 'When a bid is created' do
    it 'it is valid if all required attributes are given' do
      bid = Bid.new(user_id: 1, auction_id: @auction.id, amount: 5)
      expect(bid.valid?).to eq true
    end

    it 'it is invalid without a user_id' do
      bid = Bid.new(auction_id: @auction.id, amount: 5)
      expect(bid.valid?).to eq false
    end

    it 'it is invalid without an auction_id' do
      bid = Bid.new(user_id: 1, amount: 5)
      expect(bid.valid?).to eq false
    end

    it 'it is invalid without an amount' do
      bid = Bid.new(user_id: 1, auction_id: @auction.id)
      expect(bid.valid?).to eq false
    end

    it "is invalid if amount is lower than highest bid" do
      Bid.create(user_id: 1, auction_id: @auction.id, amount: 5)
      bid = Bid.new(user_id: 1, auction_id: @auction.id, amount: 2)

      expect(bid.valid?).to eq false
    end

    it "is invalid if the auction is expired" do
      auction = Auction.create(store_id: 1,
                               expiration_date: Time.new(2011, 10, 7),
                               starting_bid: 0,
                               shipping_options: 'International',
                               active: true)
      bid = Bid.new(user_id: 1, auction_id: auction.id, amount: 2)

      expect(bid.valid?).to eq false
    end
  end

end
