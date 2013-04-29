class StoreAdmin::AuctionsController < ApplicationController
  before_filter :require_admin

  def new
    @auction = Auction.new
    @product = @auction.build_product
  end

  def create
    @auction = Auction.new(params[:auction])
    @auction.expiration_date = DateTime.parse(params[:auction]["expiration_date"])
    if @auction.save
      redirect_to auction_path(@auction), notice: "Auction Sucessfully Created!"
    else
    fail

      redirect_to new_store_admin_auction_path, alert: "Couldn't create auction."
    end
  end
end