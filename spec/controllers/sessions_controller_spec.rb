require 'spec_helper'

describe SessionsController do

  describe 'GET #new' do
    it "renders the :new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "with valid attributes" do
      before do
        @user = create(:user)
        post :create, sessions: { email: @user.email, password: @user.password }
      end

      it "creates new user session" do
        expect(response).to redirect_to profile_path
      end

      it "sets the session[:user_id] to @user.id" do
        expect(session[:user_id]).to eq @user.id
      end
    end

    context "with invalid attributes" do
      before do
        @user = create(:user)
      end

      it "does not create a new user session" do
        post :create, sessions: { email: @user.email }
        expect(response).to render_template :new
      end

      it "does not set the session[:user_id] to @user.id" do
        post :create, sessions: { email: @user.email }
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      @user = create(:user)
      session[:user_id] = @user.id
      delete :destroy, id: @user
    end

    it "clears the session[:user_id] value" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects back to the root_path" do
      expect(response).to redirect_to root_path
    end
  end
end
