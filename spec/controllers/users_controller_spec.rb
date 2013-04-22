# require 'spec_helper'

# describe UsersController do

#   describe "GET 'new'" do
#     it "assigns a new User to @user" do
#       get :new
#       expect(assigns(:user)).to be_a_new(User)
#       # response.should be_success
#     end

#     it 'renders the new template' do
#       get 'new'
#       expect(response).to render_template :new
#     end
#   end

#   describe "GET 'show'" do
#     it "returns http success" do
#       user = User.create(full_name: "Paul", email: "s@s.com", password: "yolo", password_confirmation: "yolo")
#       get "show", id: user.id
#       response.should be_success
#     end
#   end

#   describe "POST '#create'" do
#     context "user logs in with invalid information" do
#       it "with passwords that do not match" do
#         post :create, user: {full_name: "Walter White", email: "breaking@bad.com", password: "meth", password_confirmation: "bob"}
#         expect(response).to render_template :new
#       end
#     end

#     context "user logs in with valid information" do
#       it "with passwords that match" do
#         post :create, user: {full_name: "Walter White", email: "breaking@bad.com", password: "meth", password_confirmation: "meth"}
#         expect(response).to redirect_to root_path
#       end
#     end
#   end
# end
