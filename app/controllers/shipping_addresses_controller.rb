class ShippingAddressesController < ApplicationController

  def index
    @shipping_addresses = ShippingAddress.all
  end

  def new
    @shipping_address = ShippingAddress.new
  end

  def create
    @shipping_address = ShippingAddress.new(params[:shipping_address])
    if @shipping_address.save
      redirect_to shipping_address_path(@shipping_address),
      notice: "Shipping Address Added!"
    else
      render "new"
    end
  end

  def show
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def edit
    @shipping_address = ShippingAddress.find(params[:id])
  end

  def update
    @shipping_address = ShippingAddress.find(params[:id])
    if @shipping_address.update_attributes params[:shipping_address]
      redirect_to shipping_address_path(@shipping_address)
    else
      render :edit
    end
  end

  def destroy
    shipping_address = ShippingAddress.find(params[:id])
    shipping_address.destroy
    redirect_to shipping_addresses_path
  end
end
