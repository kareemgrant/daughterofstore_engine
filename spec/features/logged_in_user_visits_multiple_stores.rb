require 'spec_helper'

feature 'Logged in user visits multiple stores' do

  context 'Given I am logged in with my StoreEngine single sign-on account' do
    context 'When I view the store at /hats' do
      it 'then i should be signed in' do
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
        click_link("Logout")
        page.should have_link("Log In")
        click_link("Log In")
        current_path.should == '/sessions/new'
        fill_in "sessions_email", :with => "email@email.com"
        fill_in "sessions_password", :with => 'pass'
        click_button("Log In")
        current_path.should == "/"
        page.should have_link("Logout")
      end
    end

    context 'When I visit "http://storeengine.com/glasses"' do
      it 'should be signed in still' do
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
        click_link("Logout")
        page.should have_link("Log In")
        click_link("Log In")
        fill_in "sessions_email", :with => "email@email.com"
        fill_in "sessions_password", :with => 'pass'
        click_button("Log In")
        visit '/hats'
        page.should have_link("Logout")
        visit '/glasses'
        page.should have_link("Logout")
        page.should_not have_link("Log In")
      end
    end
  end
end
  

