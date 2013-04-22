require 'spec_helper'

describe CartsController do
  describe "GET #show" do
    it "returns http success" do
      cart = Cart.create
      get 'show', id: cart.id
      expect(response).to render_template :show
    end
  end

  # describe "DELETE #Destroy" do
  #   let(:product){Product.create(title: "El Mormono", description: "Muy delicioso", price_in_dollars: 80.00)}
  #   session[:cart_id] = 567
  #   let(:line_item){LineItem.create(product_id: product, cart_id: session[:cart_id])}
    
  # end

end
