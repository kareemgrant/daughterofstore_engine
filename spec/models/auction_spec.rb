require 'spec_helper'

describe 'Auction:' do

  context 'When an auction is created' do
    it 'it is valid if all required attributes are given' do
      auction = Auction.new(store_id: 1, starting_bid: 0, shipping_options: 'International', expiration_date: Time.now + 3600, active: true)
      expect(auction.valid?).to eq true
    end

    it 'it is invalid without a store_id' do
      auction = Auction.new(starting_bid: 0, shipping_options: 'International', expiration_date: Time.now + 3600, active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without a starting_bid' do
      auction = Auction.new(store_id: 1, shipping_options: 'International', expiration_date: Time.now + 3600, active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without shipping_options' do
      auction = Auction.new(store_id: 1, starting_bid: 0, expiration_date: Time.now + 3600, active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without an expiration_date' do
      auction = Auction.new(store_id: 1, starting_bid: 0, shipping_options: 'International', active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid if the active field is empty' do
      auction = Auction.new(store_id: 1, starting_bid: 0, shipping_options: 'International', expiration_date: Time.now + 3600, active: nil)
      expect(auction.valid?).to eq false
    end
  end


  describe ".highest_bid" do

    it "returns the highest bid if there are bids" do
      auction = Auction.create(store_id: 1, starting_bid: 0, shipping_options: 'International', expiration_date: Time.now + 3600, active: true)
      bid1 = Bid.create(user_id: 1, auction_id: auction.id, amount: 5)
      bid2 = Bid.create(user_id: 1, auction_id: auction.id, amount: 9)
      bid3 = Bid.create(user_id: 1, auction_id: auction.id, amount: 4)

      expect(auction.highest_bid).to eq 9
    end

    it "returns 0 if there are no bids" do
      auction = Auction.create(store_id: 1, starting_bid: 0, shipping_options: 'International', expiration_date: Time.now + 3600, active: true)

      expect(auction.highest_bid).to eq 0
    end
  end

  describe ".number_of_bids" do
    it 'returns the total number of bids for an auction' do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'International',
                               expiration_date: Time.now + 3600,
                               active: true
                               )
      bid1 = Bid.create(user_id: 1, auction_id: auction.id, amount: 5)
      bid2 = Bid.create(user_id: 1, auction_id: auction.id, amount: 9)
      bid3 = Bid.create(user_id: 1, auction_id: auction.id, amount: 4)

      expect(auction.number_of_bids).to eq 2
    end

    it 'returns 0 if there are no bids for an auction' do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'International',
                               expiration_date: Time.now + 3600,
                               active: true
                               )

      expect(auction.number_of_bids).to eq 0
    end
  end

  context "when an auction expires" do
    it "sets auction status to inactive" do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'International',
                               expiration_date: Time.now + 3600,
                               active: true
                              )
      auction.expiration_date = Time.now - 3600
      auction.check_status
      expect(auction.active?).to eq false
    end
  end

end
