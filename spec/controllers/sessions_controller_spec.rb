# require 'spec_helper'

# describe SessionsController do

#   describe "GET 'new'" do
#     it "returns http success" do
#       get 'new'
#       response.should be_success
#     end

#     it 'renders the new template' do
#       get 'new'
#       expect(response).to render_template :new
#     end
#   end

#   describe 'POST #create' do

#     shared_examples "a user that fails to login" do
#       it "asks the user to login again" do
#         post :create, session: { email: "breaking@bad.com" }
#         expect(response).to render_template :new
#       end

#       it "does not set up the user session" do
#         post :create, session: { email: "breaking@bad.com" }
#         expect(session[:user_id]).to be_nil
#       end
#     end

#     context "user with email address" do

#       let!(:user) { User.create full_name: "Walter White", email: "breaking@bad.com", password: "meth" }


#       context "when the user provides a correct password" do
#         it "redirects to user to the root url" do
#           post :create, session: { email: "breaking@bad.com", password: "meth" }
#           expect(response).to redirect_to root_path
#         end

#         it "sets up the user session" do
#           post :create, session: { email: "breaking@bad.com", password: "meth" }
#           expect(session[:user_id]).to eq user.id
#         end
#       end
#     end
#   end

#   describe 'DELETE #destroy' do

#     it "clears the session user id" do
#       session[:user_id] = 567

#       post :destroy
#       expect(session[:user_id]).to be_nil
#     end

#     it "redirects to the root url" do
#       post :destroy
#       expect(response).to redirect_to root_path
#     end
#   end
# end
