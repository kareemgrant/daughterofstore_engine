class PhoneNumbersController < ApplicationController

  def new
    @phone_number = PhoneNumber.new(user_id: params[:user_id])

  end

  def create
    @phone_number = PhoneNumber.new(params[:phone_number])

      if @phone_number.save
        redirect_to @phone_number.user, notice: 'Phone number was successfully created.'
      else
        render action: "new"
      end
  end

  private
end
