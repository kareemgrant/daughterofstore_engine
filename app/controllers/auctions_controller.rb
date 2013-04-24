class AuctionsController < ApplicationController
  def index
    @auctions = Auction.all
  end

  def show
    @bid = Bid.new
    @auction = Auction.find(params[:id])
  end
end
