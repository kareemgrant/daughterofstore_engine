class StoreAdmin::StoresController < ApplicationController

  before_filter :require_admin, except: :index

  def index
    @stores = current_user.stores
  end

  def edit
    @store ||= current_store
  end

  def show
    @store ||= current_store
  end

  def update
    @store = Store.find_by_path(params[:store_id])

    if @store.update_attributes(params[:store])
      redirect_to store_admin_path, notice: "Store details were successfully updated"
    else
      render :edit
    end
  end
end
