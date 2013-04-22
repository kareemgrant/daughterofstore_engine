class CustomersController < ApplicationController
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(params[:customer])
    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to customer_path(session[:customer_id]), notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(params[:customer])
      flash[:notice] = "Profile updated!"
      redirect_to @customer
    else
      render :edit
    end
  end

end
