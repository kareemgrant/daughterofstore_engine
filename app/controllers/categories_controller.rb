class CategoriesController < ApplicationController

  def index
    @categories = current_store.categories
  end

  def show
    @categories = Category.all
    if params[:id].nil?
      @products = Product.all
    else
      @category = Category.find(params[:id])
      @products = @category.products
    end

    if @category
      render "show"
    else
      redirect_to products_path
    end
  end
end
