require 'spec_helper'

feature "StoreEngine visitor creates new account" do
  

  let!(:store){Store.create(:name => 'r store')}
  let!(:product){Product.create(:title => 'r title', :description => 'r desc', :price_in_dollars => 123, :store_id => 1)}

  context 'visitor is not logged in or previously signed up/registered' do
    context 'and visitor is on page for particular store' do
      it 'should have a sign_up link' do
        visit '/hats'
        page.should have_link("Sign Up")
      end

      it 'clicks on signup link' do
        visit '/hats'
        page.should have_link('Sign Up')
        current_path.should == '/hats'
        click_link("Sign Up")
        current_path.should == '/users/new'
      end
    end

    context "visitor is on the top-level page, 'http://storeengine.com/users/new'" do
      context 'and fills in the fields and clicks create/submit' do
        it "should create a user and return them to previous page they were on" do
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
        end

        it 'should see a confirmation flash message with a link to change my account after registering' do
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
          page.should have_link("Edit Your Account")
          page.should have_content("Click here to make changes to your account:")
        end
      end
    end

    context "visitor or someone else has created a StoreEngine account with email address before" do
      context "Visitor uses duplicate email address" do
        it 'I should see an error about duplicate email and a link to sign' do
          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          
          visit '/logout'

          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == "/users"
          expect(page).to have_content("Email has already been taken")
        end

        it 'should be able to correct the duplicate email (by changing it) and resubmit it' do
          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          
          visit '/logout'

          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == "/users"
          expect(page).to have_content("Email has already been taken")
          fill_in "user_email", :with => "email@email.net"
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == '/hats'
        end
      end
    end

    context 'Given I have not created a StoreEngine account with my email address before ' do
      context 'visitor omits full name at sign_up' do
        it 'I should see an error telling me I need to specify a full name and
         I should be able to correct it and resubmit' do

          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == "/users"
          expect(page).to have_content("Full name can't be blank")
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_display_name", :with => 'jdd'
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == '/hats'
        end
      end

      context 'Visitor omits display name at sign_up' do
        it 'should return me to the page I was on
          and I should see a confirmation flash message with a link to change my account' do
          visit '/hats'
          click_link("Sign Up")
          current_path.should == '/users/new'
          fill_in "user_full_name", :with => "James David Denman"
          fill_in "user_email", :with => "email@email.com"
          fill_in "user_password", :with => 'pass'
          fill_in "user_password_confirmation", :with => 'pass'
          click_button('Register')
          current_path.should == '/hats'
          page.should have_link("Edit Your Account")
          page.should have_content("Click here to make changes to your account:")
        end
      end
    end
  end
end
