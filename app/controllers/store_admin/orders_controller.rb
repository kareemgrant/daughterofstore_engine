class StoreAdmin::OrdersController < ApplicationController

  before_filter :require_admin
  layout 'admin'

  def show
    @order = Order.find(params[:id])
  end

  def index
    @orders = current_store.orders
  end

  def update
    @order = Order.find(params[:id])
    if @order.current_status == "pending"
      @order.cancel
    elsif @order.current_status == "shipped"
      @order.return
    elsif @order.current_status == "paid"
      @order.ship
    end
    redirect_to :back
  end
end
