class StoreAdmin::CategoriesController < ApplicationController

  before_filter :require_admin
  layout 'admin'

  def index
     @categories = current_store.categories
     @orders = current_store.orders
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes params[:category]
      redirect_to store_admin_categories_path, notice: "Category Updated!"
    else
      flash[:error] = "An error occurred, please try again"
      render :edit
    end
  end

  def create
    @category = Category.new(params[:category].merge({store_id: current_store.id}))
    if @category.save
      flash[:notice] = "Category Added!"
      redirect_to store_admin_categories_path
    else
      render "new"
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Category was successfully deleted"
    redirect_to store_admin_categories_path
  end

end
