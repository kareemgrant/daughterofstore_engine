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

    describe "PUT #update" do
      it "locates the requested @user" do
        put :update, id: @user, user: attributes_for(:user)
        expect(assigns(:user)).to eq(@user)
      end

      context "valid attributes" do
        it "changes @user's attributes" do
          put :update, id: @user, user: attributes_for(:user, full_name: "Bruce Banner")
          @user.reload
          expect(@user.full_name).to eq("Bruce Banner")
        end

        it "redirects to the update" do
          put :update, id: @user, user: attributes_for(:user)
          expect(response).to redirect_to profile_path
        end
      end

      context "invalid attributes" do
        # it "does not change @user's attributes" do
        #   put :update, id: @user, user: attributes_for(:user, full_name: "WarHawk Stark", email: nil)
        #   @user.reload
        #   expect(@user.full_name).to eq("WarHawk Stark")
        # end

        it "re-renders the edit mode" do
          put :update, id: @user, user: attributes_for(:invalid_user)
          expect(response).to render_template :edit
        end
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
        get :new
        expect(response).to render_template :new
      end
    end

    describe "POST #create" do
      context "with valid attributes" do
        it "saves the new user in the database" do
          expect{
            post :create, user: attributes_for(:user)
          }.to change(User, :count).by(1)
        end

        it "redirects to home page" do
          post :create, user: attributes_for(:user)
          expect(response).to redirect_to profile_path
        end
      end

      context "with invalid attributes" do
        it "does not save the new user in the database" do
          expect{
            post :create, user: attributes_for(:invalid_user)
            expect(response).to render_template :new
          }.to_not change(User, :count)
        end
      end
    end
  end
end
