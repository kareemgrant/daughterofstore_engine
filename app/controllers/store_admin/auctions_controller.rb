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
      prepare_auction_winner_email(date, @auction)
      redirect_to auction_path(@auction), notice: "Auction Sucessfully Created!"
    else
      render :new
    end
  end

  def update
    @auction = Auction.find(params[:id])
    @auction.active = false
    @auction.save

    Resque.enqueue_at((Time.now + 10), EndEarlyAuctionWinner, @auction.id)

    redirect_to auction_path(@auction), notice: "Auction ended early"
  end


  private

  def prepare_auction_winner_email(date, auction)
    auction.end_early = false
    auction.save
    Resque.enqueue_at(date, AuctionWinner, auction.id)
  end
end