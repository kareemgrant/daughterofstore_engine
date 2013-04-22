class StoreAdmin::ProductsController < ApplicationController

  before_filter :require_admin_or_stocker

  layout 'admin'

  def index
    @products = current_store.products
    @orders = current_store.orders
  end

  def new
    @store = current_store
    @product = current_store.products.build
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes params[:product]
      redirect_to store_admin_products_path(current_store), notice: "Product Updated!"
    else
      # flash[:error] = "An error occurred, please try again"
      render :edit
    end
  end

  def create
    @product = Product.new(params[:product].merge({store_id: current_store.id}))
    if @product.save
      redirect_to store_home_path, notice: "Product Added!"
    else
      render :new
    end
  end
end
