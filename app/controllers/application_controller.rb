class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  # rescue_from ActionController::RoutingError, :with => :render_not_found

  def require_current_store
    unless current_store
      raise ActionController::RoutingError.new("Store is offline")
    end
  end


  def get_referrer
    if request.referrer.nil?
      session[:return_to] = root_path
    elsif request.referrer.include?("login")
      session[:return_to]
    elsif request.referrer.include?("users")
      session[:return_to]
    elsif request.referrer.include?("checkout")
      session[:return_to]
    elsif request.referrer.include?("carts")
      session[:return_to] = new_order_path(current_store)
    else
      session[:return_to] = request.referrer
    end
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  def render_not_found
    # render text: "Page Not Found", status: 404
    # render file => '/public/404.html'
     render file: "#{Rails.root}/public/404", formats: :html, status: 404
  end

  # Todo = refactor and memoize
  def current_cart
    if session[:cart_id] && session[:cart_id][current_store.id]
      cart = Cart.find(session[:cart_id][current_store.id])
    else
      cart = Cart.find_or_create_by_sid_and_store_id(session[:session_id], current_store.id)
      session[:cart_id] = { current_store.id => cart.id }
    end

    cart
  end


  def current_store
    if current_user && current_user.super_admin
      @store ||= Store.where(path: params[:store_id]).first
    else
      @store ||= Store.online.where(path: params[:store_id]).first
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_consumer
    @current_consumer ||= Consumer.find(session[:consumer_id])
  end

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end


  helper_method :current_user, :current_consumer, :admin_user, :current_store, :current_cart


  def not_authenticated
    redirect_to root_path, alert: "You do not have access to this page"
  end

  def require_admin
    if current_user.nil?
      redirect_to login_path
    elsif current_store.nil? || !current_store.is_admin?(current_user)
      not_authenticated
    end
  end

  def require_admin_or_stocker
    @role = current_store.admin_or_stocker?(current_user)
    if current_store.nil? || !@role
      not_authenticated
    end
  end

  def require_super_admin
     not_authenticated unless current_user && current_user.is_super_admin?
  end

end
