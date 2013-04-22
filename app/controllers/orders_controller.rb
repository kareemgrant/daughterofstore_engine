class OrdersController < ApplicationController
  layout 'signup'
  layout 'profile', only: [:index, :show]

  before_filter :signed_in?, only: ['show', 'index']
  before_filter :checkout_funnel, only: 'new'

  def index
    consumer = Consumer.find_by_user_id(current_user.id)

    # we have the current user
    # search the consumers for the current user id
    # get the consumer id
    @orders = Order.find_all_by_consumer_id(consumer)
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      flash[:error] = "Your cart is currently empty."
      redirect_to products_path
      return
    end

    @cart = current_cart

    @order = Order.new
    @billing_address = @order.build_billing_address
    @shipping_address = @order.build_shipping_address
  end

  def create
    if current_user
      @consumer = Consumer.find_by_user_id(current_user)
      unless @consumer
        @consumer = Consumer.create(email: current_user.email, user_id: current_user.id)
      end
    else
      @consumer = Consumer.create(email: params[:order][:email])
    end
    session[:consumer_id] = @consumer.id
    @order = Order.create_from_cart(current_cart, params[:order].merge({store_id: current_store.id}), @consumer)

    if @order.id

      UserMailer.order_confirmation_email(@consumer).deliver
      current_cart.destroy
      session.delete(:cart_id)
      if current_user
        flash[:notice] = "Your payment was successfully submitted!"
        redirect_to order_path(current_store, @order)
      else
        flash[:notice] = "Your payment was successfully submitted!"
        redirect_to guest_order_url(@consumer.orders.last.random_order_id)
      end
    else
      flash.now[:notice] = "There was an error processing your card!"
      render "new"
    end
  end

  def show
    @order = Order.find(params[:id])
    if @order.consumer == current_consumer
      render "show"
    else
      flash[:error] ="You are not authorized to view another customer's orders."
      redirect_to root_path
    end
  end

  def type
    render 'checkout_funnel'
  end

  def show_guest_order
    @order = Order.find_by_random_order_id(params[:random])
  end


private
  def signed_in?
    if !current_user
      flash[:error] = "You must be logged in to checkout."
      redirect_to login_path
    end
  end

  def checkout_funnel
    unless params[:guest] || current_user
      redirect_to checkout_type_path(current_store)
      # flash[:error] = "Please log in or sign up to continue."
      # redirect_to order_path
    end
  end

end
