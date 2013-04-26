class SessionsController < ApplicationController
  layout 'session'

  def new
  end

  def create
    @user = User.find_by_email(params[:sessions][:email])
    if @user && @user.authenticate(params[:sessions][:password])
      session[:user_id] = @user.id
      flash[:notice] = "Welcome back to Shopmazing!"
      redirect_to profile_path
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
