class StoreAdmin::AuctionsController < ApplicationController
  before_filter :require_admin

  def new
    @auction = Auction.new
    @auction.build_product
    @payment_options = PaymentOption.new
    #@auction.payment_options.build
  end

  def create
    @auction = Auction.new(params[:auction])
    date = Auction.parse_expiration_date(params[:auction][:expiration_date])
    @auction.expiration_date = date.utc

    if @auction.save
      redirect_to auction_path(@auction), notice: "Auction Sucessfully Created!"
    else
      render :new
    end
  end
end