class BidsController < ApplicationController

  def create
    if current_user
      @bid = Bid.new(amount: params[:bid][:amount], auction_id: params[:auction_id], user_id: current_user.id)
      if @bid.save
        redirect_to auction_path(params[:auction_id]),
        notice: "You are currently the highest bidder!"
      else
        redirect_to auction_path(params[:auction_id]), notice: 'Bid Failed!'
      end
    else
      redirect_to login_path(return_to: auction_path(params[:auction_id])), notice: "You must log in to bid."
    end
  end

end