class UsersController < ApplicationController
  layout 'signup'

  before_filter :require_current_user, only: [:show, :edit, :update]

  def show
    @user = User.find(current_user.id)
    render :layout => 'profile'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # UserMailer.signup_confirmation_email(@user).deliver
      session[:user_id] = @user.id
      flash[:notice] = "Click here to make changes to your account: #{self.class.helpers.link_to( 'Edit Your Account', edit_profile_path) }".html_safe
      destination = session.delete(:return_to) || profile_path
      redirect_to destination
    else
      flash.now[:alert] = "You entered invalid information, please try again"
      render :new
    end
  end


  def edit
    @user = User.find(current_user.id)
    render :layout => 'profile'
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
