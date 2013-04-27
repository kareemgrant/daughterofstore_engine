require 'spec_helper'
require 'capybara/rspec'

describe 'Account Creation:' do

  context 'when an anonymous user visits the site' do
    it 'they can create an account' do
      visit '/'
      click_link 'Sign Up'
      fill_in 'user_full_name', with: 'Logan Sears'
      fill_in 'user_email', with: 'lsears322@gmail.com'
      fill_in 'user_display_name', with: 'Logan'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button 'Register'
      page.has_content?('My Account')
    end
  end

  context 'when a user has an account but is not logged in' do
    let!(:user) { User.create(full_name: 'Logan Sears',
                              email: 'lsears322@gmail.com',
                              display_name: 'Logan',
                              password: 'password')
                }

    it 'they can login to their account' do
      visit '/'
      click_link 'Log In'
      fill_in 'sessions_email', with: 'lsears322@gmail.com'
      fill_in 'sessions_password', with: 'password'
      click_button 'Log In'
      page.has_content?('My Account')
    end
  end

end
