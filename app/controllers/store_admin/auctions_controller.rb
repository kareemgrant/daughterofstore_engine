class StoreAdmin::AuctionsController < ApplicationController
  before_filter :require_admin

  def new
    @auction = Auction.new
    @auction.build_product
    @auction.payment_options.build
  end

  def create
    @auction = Auction.new(params[:auction])
    date = Auction.parse_expiration_date(params[:auction][:selected_expiration_date])
    @auction.expiration_date = date

    if @auction.save
      Resque.enqueue_at(date, AuctionWinner, @auction.id)
      redirect_to auction_path(@auction), notice: "Auction Sucessfully Created!"
    else
      render :new
    end
  end
end