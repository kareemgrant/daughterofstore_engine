class BidsController < ApplicationController

  # def create
  #   if current_user
  #     @bid = Bid.new(amount: params[:bid][:amount], auction_id: params[:auction_id], user_id: current_user.id)
  #     @bid.save ? notice_message : alert_message
  #   else
  #     redirect_to login_path(return_to: auction_path(params[:auction_id])),
  #     alert: "You must log in to bid."
  #   end
  # end
  def create
    if current_user
      @bid = Bid.new(amount: params[:bid][:amount], auction_id: params[:auction_id], user_id: current_user.id)
      @bid.save ? notice_message : alert_message
    else
      redirect_to login_path(return_to: auction_path(params[:auction_id])),
      alert: "You must log in to bid."
    end
  end

  private

  def notice_message
    redirect_to auction_path(params[:auction_id]),
    notice: "You are currently the highest bidder!"
  end

  def alert_message
    redirect_to auction_path(params[:auction_id]),
    alert: 'Your bid must be higher than the current bid'
  end
end