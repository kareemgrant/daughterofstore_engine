require 'spec_helper'

describe Admin::CategoriesController do

  before :each do
    @user = User.create(full_name: 'Michael J', email: 'mj@mj.com', password: 'password')
    @user.admin = true
    @user.save
    session[:user_id] = @user.id
  end

  describe "GET #index" do
    it "populates an array of categories" do
      category = Category.create(name: "Football")
      get :index
      expect(assigns(:categories)).to match_array [category]
    end

    it "renders the :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #new" do
    it "assigns a new Category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end

    it "renders the #new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested category to @category" do
      category = Category.create(name: "Football")
      get :edit, id: category
      expect(assigns(:category)).to eq category
    end

    it "renders the :edit template" do
      category = Category.create(name: "Football")
      get :edit, id: category
      expect(response).to render_template :edit
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new category in the database" do
        expect {
          post :create, category: {name: "football"}
        }.to change(Category, :count).by(1)
      end

      it "redirects to the admin category list page" do
        post :create, category: {name: "football"}
        expect(response).to redirect_to admin_categories_path
      end
    end

    context "with invalid attributes" do
      it "does not save the new category in the database" do
        expect{
          post :create, category: {name: nil}
        }.to_not change(Category, :count)
      end

      it "re-renders the :new template" do
        post :create, category: {name: nil}
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before do
      @category = Category.create(name: "football")
    end

    it "locates the requested @category" do
      put :update, id: @category, category: {name: "football"}
      expect(assigns(:category)).to eq @category
    end

    context "valid attributes" do
      it "changes @category's attributes" do
        put :update, id: @category, category: {name: "basketball"}
        @category.reload
        expect(@category.name).to eq("basketball")
      end

      it "redirects to the admin category list page" do
        put :update, id: @category, category: {name: "football"}
        expect(response).to redirect_to(admin_categories_path)
      end
    end

    context "invalid attributes" do
      # it "re-renders the edit method" do
      #   puts :update, id: @category, category: {name: nil}
      #   expect(response).to render_template :edit
      # end
    end
  end

  describe "DELETE destroy" do
    before do
      @category = Category.create(name: "football")
    end

    it "deletes the category" do
      expect{
        delete :destroy, id: @category
      }.to change(Category, :count).by(-1)
    end

    it "redirects to admin category list page" do
      delete :destroy, id: @category
      expect(response).to redirect_to admin_categories_path
    end
  end

end
