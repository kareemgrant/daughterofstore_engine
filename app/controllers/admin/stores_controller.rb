class Admin::StoresController < Admin::BaseController


  layout 'none'

  def index
    @all_stores = Store.all
    case params[:status]
    when "pending"
      @stores = Store.pending
      @flag = "pending"
    when "approved"
      @stores = Store.approved
      @flag = "approved"
    when "declined"
      @flag = "declined"
      @stores = Store.declined
    else
      # figure how to handle unknown requests
      @stores = Store.approved
    end
  end

  def edit
    @store = Store.find(params[:store_id])
  end

  def update
    binding.pry
    @store = Store.find_by_path(params[:id])
    if params[:toggle] == "approve"
      @store.update_attributes({status: "online"}) if @store.status == "pending" || @store.status == "declined"
      redirect_to admin_stores_path, notice: "status successfully updated"
    elsif params[:toggle] == "decline"
      @store.update_attributes({status: "declined"}) if @store.status == "pending"
      redirect_to admin_stores_path, notice: "status successfully updated"
    elsif params[:toggle] == "disable"
      @store.update_attributes({status: "offline"}) if @store.status == "online"
      redirect_to admin_stores_path, notice: "status successfully updated"
    elsif params[:toggle] == "enable"
      @store.update_attributes({status: "online"}) if @store.status == "offline"
      redirect_to admin_stores_path, notice: "status successfully updated"
    else
      @store
      flash[:alert] = "Invalid action"
      render admin_stores_path
    end
  end

  def show
    @all_stores = Store.all
    @store = Store.find(params[:store_id])
  end

end
