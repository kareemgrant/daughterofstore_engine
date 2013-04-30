class StoreAdmin::AuctionsController < ApplicationController
  before_filter :require_admin

  def new
    @auction = Auction.new
    @auction.build_product
    @auction.payment_options.build
  end

  def create
    @auction = Auction.new(params[:auction])

    if @auction.save
      redirect_to auction_path(@auction), notice: "Auction Sucessfully Created!"
    else
      render :new
    end
  end
end