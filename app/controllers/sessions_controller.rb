class SessionsController < ApplicationController
  layout 'session'

  def new
  end

  def index
  end

  def create
    @user = User.find_by_email(params[:sessions][:email])
    if @user && @user.authenticate(params[:sessions][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to Shopmazing!"
      # redirect_to stores_path
      redirect_to session[:return_to] || stores_path
    else
      flash[:alert] = "Invalid email or password"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout Successful!"
    redirect_to :back
  end

end
