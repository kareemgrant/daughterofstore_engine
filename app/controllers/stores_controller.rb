class StoresController < ApplicationController
  layout 'session'
  before_filter :require_current_user, only: ['index']

  def index
    @stores = current_user.stores
    render :layout => 'profile'
  end

  def new
    @store = Store.new
   @store.users.build
    render :stores => 'new'
  end

  def create
    @store = Store.new(params[:store])

    if @store.save
      current_user.assign_role(@store.id, 'admin')
      flash[:notice] = "Your store is pending approval"
      redirect_to profile_path
    else
      flash[:notice] = "There was a problem"
      render "new"
    end
  end

  def show
    @store = Store.find(params[:store_id])
  end


end
