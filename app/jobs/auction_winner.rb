class AuctionWinner
  @queue = :auction_winner

  def self.perform(auction_id)
    auction = Auction.find(auction_id)
    unless auction.end_early
      UserMailer.auction_winner_email(auction).deliver
    end
  end
end
