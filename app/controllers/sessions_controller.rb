class SessionsController < ApplicationController
  layout 'session'

  def new
    session[:return_to] = params[:return_to]
  end

  def create
    @user = User.find_by_email(params[:sessions][:email])
    if @user && @user.authenticate(params[:sessions][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back to Shopmazing!"
      destination = session.delete(:return_to) || auctions_path
      redirect_to destination
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout Successful!"
    redirect_to root_path
  end

end
