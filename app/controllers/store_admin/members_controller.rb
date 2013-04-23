class StoreAdmin::MembersController < ApplicationController

  before_filter :require_admin
  layout 'admin'

  def index
    @admins = UserStoreRole.where(store_id: current_store.id, role: 'admin').map(&:user)
    @stockers = UserStoreRole.where(store_id: current_store.id, role: 'stocker').map(&:user)
  end

  def new
    if params[:role] == 'admin'
      @role = 'admin'
    else
      @role = 'stocker'
    end

    @member = UserStoreRole.new
  end

  def create
    @user = User.find_by_email(params[:invite][:email])
    if @user
      @user.assign_role(current_store.id, params[:invite][:role])
      logger.debug("Sending Email to existing user")
    else

      logger.debug("Sending Email to new user")
    end

    flash[:notice] = "Member Invited!"
    redirect_to store_admin_members_path
  end

  def destroy

    @user_store_role = UserStoreRole.where(store_id: params[:id], user_id: params[:user]).first
    @user_store_role.destroy


    flash[:notice] = "Member Removed"
    redirect_to store_admin_members_path

  end


  private

  def get_store_users
    @members ||= current_store.users
  end
end

