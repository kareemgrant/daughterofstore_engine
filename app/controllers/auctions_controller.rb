class AuctionsController < ApplicationController

  def index
    @auctions = Auction.includes(:product).all
  end

  def show
    @bid = Bid.new
    @auction = Auction.find(params[:id])
    @auction.check_status

    @related_auctions = related_auctions(@auction)
  end

  private

  def related_auctions(auction)
    all_auctions = Auction.includes(:product).where(store_id: auction.store.id)
    all_auctions.reject{|n| n == auction}
  end

end
