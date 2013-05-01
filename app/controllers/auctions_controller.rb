class AuctionsController < ApplicationController

  def index
    @auctions = Auction.includes(:product).all
  end

  def show
    @bid = Bid.new
    @auction = Auction.find(params[:id])
    @auction.check_status
  end
end
