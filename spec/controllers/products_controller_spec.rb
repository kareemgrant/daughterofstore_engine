require 'spec_helper'

describe ProductsController do

  before do
  @store = Store.create(name:        "somename",
                             path:        "somepath",
                             description: "somedescription",
                             status:      "online")
  end

  describe "GET #index" do

    it "returns http success" do
      pending
      get 'index', store_id: store
      response.should be_success
    end

    it "renders the index template" do
      pending
      get 'index', store_id: store
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "shows a single product" do
      pending
      product = Product.create(title: "El Mormono Hamberguesa con Queso con largo papas fritas", description: "Muy delicioso", price_in_dollars: 80.00)
      get 'show', id: product.id, store_id: store
      expect(response).to render_template :show
    end
  end

end

