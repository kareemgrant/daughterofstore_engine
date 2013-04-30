require 'spec_helper'

describe 'Auction:' do

  context 'When an auction is created' do
    it 'it is valid if all required attributes are given' do
      auction = Auction.new(store_id: 1,
                            starting_bid: 0,
                            shipping_options: 'international',
                            expiration_date: DateTime.now + 1,
                            active: true)
      expect(auction.valid?).to eq true
    end

    it 'it is invalid without a store_id' do
      auction = Auction.new(starting_bid: 0,
                            shipping_options: 'international',
                            expiration_date: DateTime.now + 1,
                            active: true)
      expect(auction.valid?).to eq false
    end

    it 'it is invalid without a starting_bid' do
      auction = Auction.new(store_id: 1,
                            shipping_options: 'international',
                            expiration_date: DateTime.now + 1,
                            active: true)
      expect(auction.valid?).to eq false
    end
  end


  describe ".highest_bid" do

    it "returns the highest bid if there are bids" do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'international',
                               expiration_date: DateTime.now + 1,
                               active: true)
      bid1 = Bid.create(user_id: 1, auction_id: auction.id, amount: 5)
      bid2 = Bid.create(user_id: 1, auction_id: auction.id, amount: 9)
      bid3 = Bid.create(user_id: 1, auction_id: auction.id, amount: 4)

      expect(auction.highest_bid).to eq 9
    end

    it "returns 0 if there are no bids" do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'international',
                               expiration_date: DateTime.now + 1,
                               active: true)

      expect(auction.highest_bid).to eq 0
    end
  end

  describe ".number_of_bids" do
    it 'returns the total number of bids for an auction' do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'international',
                               expiration_date: DateTime.now + 1,
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
                               shipping_options: 'international',
                               expiration_date: DateTime.now + 1,
                               active: true
                               )

      expect(auction.number_of_bids).to eq 0
    end
  end

  context "when an auction expires" do
    it "sets auction status to inactive" do
      auction = Auction.create(store_id: 1,
                               starting_bid: 0,
                               shipping_options: 'international',
                               expiration_date: DateTime.now + 1,
                               active: true
                              )
      auction.expiration_date = DateTime.now - 1
      auction.check_status
      expect(auction.active?).to eq false
    end
  end

  describe "#highest_bidder" do
    it "returns the user with the highest bid" do
      auction = Auction.create(store_id: 1,
                            starting_bid: 0,
                            shipping_options: 'international',
                            expiration_date: Time.new(2014, 4, 27),
                            active: true
                           )
      user1 = User.create(full_name: "somedude1",
                          email:     "somedude1@email.com",
                          password:  "password")
      user2 = User.create(full_name: "somedude2",
                          email:     "somedude2@email.com",
                          password:  "password")

      user1.bids.create(auction_id: auction.id, amount: 5)
      user2.bids.create(auction_id: auction.id, amount: 9)
      expect(auction.highest_bidder).to eq user2
    end
  end

  describe ".parse_expiration_date" do
    it "accepts a date as a string and converts it to a DateTime object" do
      date_object = DateTime.new(2013, 9, 23, Time.now.hour, Time.now.min, Time.now.sec)
      parsed_date = Auction.parse_expiration_date("9/23/2013")

      expect(date_object).to eq parsed_date
    end
  end
end
