class StoreAdmin::AuctionsController < ApplicationController
  before_filter :require_admin

  def new
    @auction = Auction.new
    @auction.build_product
  end

  def create
    @auction = Auction.new(params[:auction])

    date = parse_expiration_date(params[:auction][:expiration_date])

    @auction.expiration_date = date.utc
    if @auction.save
      redirect_to auction_path(@auction), notice: "Auction Sucessfully Created!"
    else
      redirect_to new_store_admin_auction_path, alert: "Couldn't create auction."
    end
  end

  private

  def parse_expiration_date(string_date)
    date = nil
    string_date.split("/").map {|n| n.to_i}.tap do |month, day, year|
      date = DateTime.new(year, month, day, Time.now.hour, Time.now.min, Time.now.sec)
    end
    date
  end
end