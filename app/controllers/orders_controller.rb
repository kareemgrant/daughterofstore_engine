class OrdersController < ApplicationController

  layout 'signup'
  layout 'profile', only: [:index, :show]

  before_filter :signed_in?, only: ['show', 'index']

  def index
    @orders = Order.find_all_by_user_id(current_user)
  end

  def new
    @order = Order.new
    @billing_address = @order.build_billing_address
    @shipping_address = @order.build_shipping_address
  end

  def create
  end

  def show
  end


  private

  def signed_in?
    if !current_user
      flash[:error] = "You must be logged in to view this page"
      redirect_to login_path
    end
  end

end
