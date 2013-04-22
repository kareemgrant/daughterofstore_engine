class BillingAddressController < ApplicationController

  def index
    @billing_address = BillingAddress.all
  end

  def new
    @billing_address = BillingAddress.new
  end

  def create
    @billing_address = BillingAddress.new(params[:billing_address])
    if @billing_address.save
      redirect_to billing_address_path(@billing_address),
      notice: "Billing Address Added!"
    else
      render "new"
    end
  end

  def show
    @billing_address = BillingAddress.find(params[:id])
  end

  def edit
    @billing_address = BillingAddress.find(params[:id])
  end

  def update
    @billing_address = BillingAddress.find(params[:id])
    if @billing_address.update_attributes params[:billing_address]
      redirect_to billing_address_path(@billing_address)
    else
      render :edit
    end
  end

  def destroy
    billing_address = BillingAddress.find(params[:id])
    billing_address.destroy
    redirect_to billing_address_path
  end
end
