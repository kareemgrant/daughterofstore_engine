class AuctionWinner
  @queue = :auction_winner

  # def self.perform(auction_id)
  #   auction = Auction.find_by_id(auction_id)
  #   UserMailer.auction_winner_email(auction).deliver
  # end

  def self.perform(auction_id)
    auction = Auction.find_by_id(auction_id)

    if auction.expiration_date.today? && auction.active?
      UserMailer.auction_winner_email(auction).deliver
    end
  end


end
