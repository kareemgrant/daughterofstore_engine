require 'spec_helper'

describe ShippingAddressesController do
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

  describe "GET #new" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it 'renders the new template' do
      get 'new'
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with invalid information" do
      it "has no street" do 
        post :create, shipping_address: {city: "Beverly Hills", state: "California", zipcode: "90210"}
        expect(response).to render_template :new
      end

      it "has no city" do
        post :create, shipping_address: {street: "415 Bluebird Street", state: "California", zipcode: "90210"}
        expect(response).to render_template :new
      end

      it "has no state" do
        post :create, shipping_address: {street: "415 Bluebird Street", city: "Beverly Hills", zipcode: "90210"} 
        expect(response).to render_template :new
      end

      it "has no zipcode" do
        post :create, shipping_address: {street: "415 Bluebird Street", city: "Beverly Hills", state: "California"} 
        expect(response).to render_template :new
      end
    end

    context "with valid information" do
      it "creates new shipping address" do
        post :create, shipping_address: {street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210"}
        shipping_address = assigns(:shipping_address)
        expect(response).to redirect_to shipping_address_path(shipping_address)
      end
    end
  end

  describe "GET #show" do
    it "shows a shipping address" do
      shipping_address = ShippingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
      get 'show', id: shipping_address.id
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "renders template edit" do
      shipping_address = ShippingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
      get 'edit', id: shipping_address.id
      expect(response).to render_template :edit
    end
  end

  describe "POST #update" do
    context "with invalid information" do
      it "does not update a shipping address" do
        shipping_address = ShippingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
        put :update, id: shipping_address.id, shipping_address: {street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: nil}
        expect(response).to render_template :edit
      end
    end
  end
  describe "DELETE #destroy" do
    context "removing items from shipping_address index" do
      it "redirects after delete" do
        shipping_address = ShippingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
        delete :destroy, id: shipping_address.id 
        expect(response).to redirect_to shipping_addresses_path
      end
      it "removes a shipping address" do
        shipping_address = ShippingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
        delete :destroy, id: shipping_address.id
        expect(ShippingAddress.exists?(shipping_address.id)).to eq false 
      end
    end
  end
end
