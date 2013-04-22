class CategoriesController < ApplicationController

  def index
    @categories = current_store.categories
  end

#     respond_to do |format|
#if @category.save
#         format.html { redirect_to @category,
#         notice: 'Category was successfully created.'}
#         format.json { render json: @category, status: :created,
          #location: @category }
#       else
# format.html { render action: "new" }
#         format.json { render json: @category.errors,
          #status: :unprocessable_entity }
#       end
#     end
#   end

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

    # @products_by_category = {}
    # categories.each do |cat|
    #   @products_by_category[cat] = Product.find(params[cat.to_sym]).limit(4)
    # end
  end
end
