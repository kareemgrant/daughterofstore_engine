require 'spec_helper'

describe Admin::ProductsController do

  before :each do
    @user = User.create(full_name: 'Michael J', email: 'mj@mj.com', password: 'password')
    @user.admin = true
    @user.save
    session[:user_id] = @user.id
  end
  

  describe "GET #index" do

    it "populates an array of messages" do

      product = Product.create(title: "Yes", description: "No", price_in_dollars: 7.00)
      get :index
      expect(assigns(:products)).to match_array [product]
    end

    it "renders the index template" do
      get 'index'
      expect(response).to render_template :index
    end
  end


  describe 'GET #show' do 

    before do 
      @product = Product.create(title: "Yes", description: "No", price_in_dollars: 7.00)
    end

    it "assigns the requested product to @product" do 
      get :show, id: @product
      expect(assigns(:product)).to eq @product
    end

    it "renders the :show template" do
      get :show, id: @product
      expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    
    it "assigns a new Product to @product" do 
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'renders the :new template' do
      get 'new'
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do 
    it "assigns the requested product to @product" do
      product = product = Product.create(title: "Yes", description: "No", price_in_dollars: 7.00)

      get :edit, id: product
      expect(assigns(:product)).to eq product
    end

    it "renders to the :edit template" do 
      product = product = Product.create(title: "Yes", description: "No", price_in_dollars: 7.00)

      get :edit, id: product
      expect(response).to render_template :edit
    end
  end
  
  describe "POST #create" do 
    context "with valid attributes" do 
      it "saves the new product in the database" do 
        expect {
          post :create, product: {title: "Yes", description: "No", price_in_dollars: 7.00} }.to change(Product, :count).by(1)
      end

      it "redirects to the admin product list page" do
        post :create, product: {title: "Yes", description: "No", price_in_dollars: 7.00}
        expect(response).to redirect_to admin_products_path
      end
    end
    
    context "with invalid attributes" do 
      it "does not save the new message in the database" do 
        expect {
          post :create, product: {description: "No", price_in_dollars: 7.00} 
        }.to_not change(Product, :count)
      end

      it "re-renders the :new template" do 
        post :create, product: {description: "No", price_in_dollars: 7.00}
        expect(response).to render_template :new 
      end
    end
  end

  describe "PUT #update" do 
    before do 
      @product = product = Product.create(title: "Yes", description: "No", price_in_dollars: 7.00)
    end

    it "locates the requested @product" do 
      put :update, id: @product, product: {title: "Yes", description: "No", price_in_dollars: 7.00}

      expect(assigns(:product)).to eq @product
    end

    context "valid attributes" do 
      it "changes @product's attributes" do 
        put :update, id: @product, product: {title: "No Sir", description: "No", price_in_dollars: 7.00} 
        @product.reload
        expect(@product.title).to eq "No Sir"
      end

      it "redirects to the update message" do 
        put :update, id: @product, product: {title: "Yes", description: "No", price_in_dollars: 7.00}

        expect(response).to redirect_to admin_products_path
      end
    end

    context "invalid attributes" do 
      # it "does not change @product's attributes" do 
      #   put :update, id: @product, product: {title: "Not yet", description: "No", price_in_dollars: -7.00}
      #   @product.reload
      #   expect(@product.title).to eq "Not yet"
      # end

      # it "re-renders the edit method" do 
      #   puts :update, product: {title: "Not yet", description: "No", price_in_dollars: -7.00}
      #   expect(response).to render_template :edit
      # end
    end
  end
end
