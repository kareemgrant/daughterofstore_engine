require 'spec_helper'

describe 'Auction:' do

  context 'When an auction is created' do
    it 'it is valid if all required attributes are given' do
      auction = Auction.new(store_id: 1, starting_bid: 0, shipping_options: 'International', duration: 3, active: true)
      expect(auction.valid?).to eq true
    end

    it 'it is invalid without a store_id' do
      auction = Auction.new(starting_bid: 0, shipping_options: 'International', duration: 3, active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without a starting_bid' do
      auction = Auction.new(store_id: 1, shipping_options: 'International', duration: 3, active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without shipping_options' do
      auction = Auction.new(store_id: 1, starting_bid: 0, duration: 3, active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without a duration' do
      auction = Auction.new(store_id: 1, starting_bid: 0, shipping_options: 'International', active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid if the active field is empty' do
      auction = Auction.new(store_id: 1, starting_bid: 0, shipping_options: 'International', duration: 3)
      expect(auction.valid?).to eq false
    end
  end

end
