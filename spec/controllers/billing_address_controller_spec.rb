require 'spec_helper'

describe BillingAddressController do
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
        post :create, billing_address: {city: "Beverly Hills", state: "California", zipcode: "90210"}
        expect(response).to render_template :new
      end

      it "has no city" do
        post :create, billing_address: {street: "415 Bluebird Street", state: "California", zipcode: "90210"}
        expect(response).to render_template :new
      end

      it "has no state" do
        post :create, billing_address: {street: "415 Bluebird Street", city: "Beverly Hills", zipcode: "90210"} 
        expect(response).to render_template :new
      end

      it "has no zipcode" do
        post :create, billing_address: {street: "415 Bluebird Street", city: "Beverly Hills", state: "California"} 
        expect(response).to render_template :new
      end
    end

    context "with valid information" do
      it "creates new billing address" do
        post :create, billing_address: {street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210"}
        billing_address = assigns(:billing_address)
        expect(response).to redirect_to billing_address_path(billing_address)
      end
    end
  end

  describe "GET #show" do
    it "shows a billing address" do
      billing_address = BillingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
      get 'show', id: billing_address.id
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    it "renders template edit" do
      billing_address = BillingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
      get 'edit', id: billing_address.id
      expect(response).to render_template :edit
    end
  end

  describe "POST #update" do
    context "with invalid information" do
      it "does not update an address" do
        billing_address = BillingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
        put :update, id: billing_address.id, billing_address: {street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: nil}
        expect(response).to render_template :edit
      end
    end
  end
  describe "DELETE #destroy" do
    context "removing items from billing_address index" do
      it "redirects after delete" do
        billing_address = BillingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
        delete :destroy, id: billing_address.id 
        expect(response).to redirect_to billing_address_path
      end
      it "removes a billing address" do
        billing_address = BillingAddress.create(street: "415 Bluebird Street", city: "Beverly Hills", state: "California", zipcode: "90210")
        delete :destroy, id: billing_address.id
        expect(BillingAddress.exists?(billing_address.id)).to eq false 
      end
    end
  end

end
