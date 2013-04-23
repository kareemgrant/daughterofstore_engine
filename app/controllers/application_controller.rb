class ApplicationController < ActionController::Base
  protect_from_forgery

  # rescue_from ActionController::RoutingError, :with => :render_not_found

  def require_current_store
    unless current_store
      raise ActionController::RoutingError.new("Store is offline")
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

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end


  helper_method :current_user, :admin_user, :current_store


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
