class ProductsController < ApplicationController

  def index
    @search = Product.search(:include => [:auction]) do
      fulltext params[:search]
    end
    @products = @search.results
  end

end
