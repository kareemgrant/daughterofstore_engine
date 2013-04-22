class StoreAdmin::OrdersController < ApplicationController

  before_filter :require_admin
  layout 'admin'

  def show
    @order = Order.find(params[:id])
  end

  def index
    # @orders = Order.all
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
      # @order.send_text_message
    end
    redirect_to :back
  end

  def add_quantity_to_order
    order = LineItem.find(params[:id]).order
    order.add_quantity(params[:id])
    redirect_to :back
  end

  def decrease_quantity_from_order
    order = LineItem.find(params[:id]).order
    order.decrease_quantity(params[:id])
    redirect_to :back
  end

  def increase_quantity
    binding.pry
    order = Order.find(params[:id])
    product = Product.find(params[:id])
    line_item = LineItem.find(product)
    line_item.quantity +=1
    line_item.save
    redirect_to :back
  end

  def decrease_quantity
    product = Product.find(params[:id])
    line_item = current_cart.line_items.find_by_product_id(product)
    line_item.quantity -=1
    line_item.save
    redirect_to :back
  end
end
