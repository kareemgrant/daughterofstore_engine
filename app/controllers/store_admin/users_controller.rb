class StoreAdmin::UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_phone_number
    render :layout => 'application'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_user_path(@user), notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user.build_phone_number unless @user.phone_number
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Profile updated!"
      redirect_to @user
    else
      render :edit
    end
  end

end
