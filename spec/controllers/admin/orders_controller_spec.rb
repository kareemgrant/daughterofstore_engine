require 'spec_helper'

describe Admin::OrdersController do

  before :each do
    @user = User.create(full_name: 'Michael J', email: 'mj@mj.com', password: 'password')
    @user.admin = true
    @user.save
    session[:user_id] = @user.id
  end

  describe 'GET #index' do
    it 'assigns the requested order to @order' do
      get :index
      response.should be_success
    end
  end

  describe "GET #show" do
    it "shows the order" do
      order = Order.create(total_price: 200, user_id: @user.id)
      get 'show', id: order.id
      response.should be_success
    end
  end
end
