require 'spec_helper'

describe UsersController do

  context "when the user is logged in" do

    before do
      controller.stub(:require_current_user).and_return(true)
      @user = create(:user)
      controller.stub(:current_user).and_return(@user)
    end

    describe 'GET #show' do
      it "assigns the requested user to @user" do

        get :show, id: @user
        expect(assigns(:user)).to eq @user
      end

      it "renders the :show template" do
        get :show, id: @user
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      it "assigns the requested user to @user" do
        get :edit, id: @user
        expect(assigns(:user)).to eq @user
      end

      it "renders the :edit template" do
        get :edit, id: @user
        expect(response).to render_template :edit
      end
    end
  end

  context "when user is not logged in" do


    describe 'Get #new' do
      it "assigns a new user to @user" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end

      it "renders the :new template" do

      end
    end
  end

  # describe "GET 'new'" do
  #   it "assigns a new User to @user" do
  #     get :new
  #     expect(assigns(:user)).to be_a_new(User)
  #     # response.should be_success
  #   end

  #   it 'renders the new template' do
  #     get 'new'
  #     expect(response).to render_template :new
  #   end
  # end

  # describe "GET 'show'" do
  #   it "returns http success" do
  #     user = User.create(full_name: "Paul", email: "s@s.com", password: "yolo", password_confirmation: "yolo")
  #     get "show", id: user.id
  #     response.should be_success
  #   end
  # end

  # describe "POST '#create'" do
  #   context "user logs in with invalid information" do
  #     it "with passwords that do not match" do
  #       post :create, user: {full_name: "Walter White", email: "breaking@bad.com", password: "meth", password_confirmation: "bob"}
  #       expect(response).to render_template :new
  #     end
  #   end

  #   context "user logs in with valid information" do
  #     it "with passwords that match" do
  #       post :create, user: {full_name: "Walter White", email: "breaking@bad.com", password: "meth", password_confirmation: "meth"}
  #       expect(response).to redirect_to root_path
  #     end
  #   end
  # end
end
