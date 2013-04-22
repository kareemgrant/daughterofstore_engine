require 'spec_helper'

describe ProductsController do
  describe "GET #index" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "renders the index template" do
      get 'index'
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "shows a single product" do
      product = Product.create(title: "El Mormono Hamberguesa con Queso con largo papas fritas", description: "Muy delicioso", price_in_dollars: 80.00)
      get 'show', id: product.id
      expect(response).to render_template :show
    end
  end

end

