class ProductsController < ApplicationController
  before_filter :require_current_store

  def index
    @products = current_store.products.page.per(16)
  end

  def show
    @product = current_store.products.find(params[:id])
  end
end
