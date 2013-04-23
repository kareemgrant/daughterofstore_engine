class UsersController < ApplicationController
  layout 'profile'

  def index
    @users = User.all
  end

  def new
    @user = User.new
    render :layout => 'session'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      UserMailer.signup_confirmation_email(@user).deliver
      session[:user_id] = @user.id
      flash[:notice] = "Click here to make changes to your account: #{self.class.helpers.link_to( 'Edit Your Account', edit_profile_path) }".html_safe
      redirect_to profile_path
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated!"
      redirect_to profile_path
    else
      render :edit
    end
  end

end
