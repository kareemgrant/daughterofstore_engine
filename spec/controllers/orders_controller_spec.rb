require 'spec_helper'

describe OrdersController do

  describe "GET #index" do
    it "shows all orders" do
      user = User.create(full_name: "Erin", email: "e@e.com", password: "password")
      session[:user_id] = user.id
      order = Order.create(total_price: 200, user_id: user.id)
      get 'index'
      response.should be_success
    end
  end

  describe "GET #show" do
    it "shows the order" do
      user = User.create(full_name: "Erin", email: "e@e.com", password: "password")
      session[:user_id] = user.id
      order = Order.create(total_price: 200, user_id: user.id)
      get 'show', id: order.id
      response.should be_success
    end
  end
end
