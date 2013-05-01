require 'spec_helper'
require 'capybara/rspec'

feature "User registration" do

  background do
    visit signup_path
  end

  given(:submit) { "Register" }

  scenario "user signs up valid information" do

    expect{
      fill_in "Full Name", with: "Bruce Banner"
      fill_in "Email", with: "hulk@example.com"
      fill_in "user_display_name", with: "hulk"
      fill_in "user_password", with: "password"
      fill_in "user_password_confirmation", with: "password"
      click_button submit
    }.to change(User, :count).by(1)

    expect(current_path).to eq(auctions_path)

    within '.alert' do
      expect(page).to have_content 'Click here to make changes to your account'
    end

    expect(page).to have_link("Logout", href: logout_path)
  end

  scenario "user signs up with invalid information" do

    expect{
      fill_in "Full Name", with: "Bruce Banner"
      fill_in "Email", with: "hulk@example.com"
      fill_in "user_display_name", with: "hulk"
      fill_in "user_password", with: "wrong password"
        fill_in "user_password_confirmation", with: "password"
      click_button submit
    }.to_not change(User, :count).by(1)

    expect(current_path).to eq(users_path)

    within '.alert' do
      expect(page).to have_content "Password doesn't match confirmation"
    end
  end
end

feature "User login" do

  background do
    @user = create(:user)
    visit login_path
  end

  given(:submit) { "Log In" }

  scenario "user signs in with valid information" do
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button submit

    expect(current_path).to eq auctions_path

    within '.alert' do
      expect(page).to have_content 'Welcome back to Shopmazing!'
    end

    expect(page).to have_link("Logout", href: logout_path)
  end

  scenario "user signs in with invalid information" do
    fill_in "Email", with: @user.email
    fill_in "Password", with: "wrong password"
    click_button submit

    expect(current_path).to eq sessions_path

    within '.alert' do
      expect(page).to have_content 'Invalid email or password'
    end
  end
end
