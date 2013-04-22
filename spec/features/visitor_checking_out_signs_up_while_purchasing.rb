require 'spec_helper'


feature "Scenario: Visitor signs in during checkout" do
  context "Given I am a visitor to the store /hats" do
    context "And I have added items to my cart" do
      context "Given I have a StoreEngine account" do
        it "when I checkout, I can sign in to my existing account" do
          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == '/hats'
          page.should have_link("Logout")
          click_link "Logout"
          visit '/hats'
          current_path.should == "/hats"
          page.should have_content "Mobster Hat"
          click_link("Mobster Hat")
          current_path.should == "/hats/products/mobster-hat"
          page.should have_button "Add to Cart"
          click_button "Add to Cart"
          current_path.should == "/hats/products/mobster-hat"
          page.should have_link "My Cart"
          click_link "My Cart"
          page.should have_button "Checkout"
          click_button "Checkout"
          current_path.should == "/login"
          fill_in "sessions_email", :with => "email@email.com"
          fill_in "sessions_password", :with => 'pass'
          click_button("Log In")
          current_path.should include("/hats/carts")
        end
      end

      context 'When I checkout' do
        context 'And I can sign in to my existing account' do
          it 'I can provide my email, billing, shipping, and credit card info to purchase directly' do

          end
        end
      end

      context 'When I choose to sign in' do
        it 'should be logged in And I am returned to my checkout process' do

        end

        it 'should be able to make purchase normally' do

        end
      end
    end
  end
end
