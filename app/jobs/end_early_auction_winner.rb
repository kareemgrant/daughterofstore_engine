class EndEarlyAuctionWinner
  @queue = :end_early_auction_winner

  def self.perform(auction_id)
    auction = Auction.find_by_id(auction_id)
    UserMailer.end_early_auction_winner_email(auction).deliver
  end
end