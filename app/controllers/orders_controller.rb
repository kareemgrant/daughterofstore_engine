class OrdersController < ApplicationController

  layout 'signup'
  layout 'profile', only: [:index, :show]

  before_filter :require_current_user, only: ['show', 'index']

  def index
    # @orders = Order.find_all_by_user_id(current_user)
  end

  def new
    # @order = Order.new
    # @billing_address = @order.build_billing_address
    # @shipping_address = @order.build_shipping_address
  end

  def create
  end

  def show
  end

end
