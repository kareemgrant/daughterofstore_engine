require 'spec_helper'
require 'capybara/rspec'

describe "User pages" do
  subject { page }

  describe "signup" do
    before { visit signup_path }
    let(:submit) { "Register" }

    describe "with invalid information" do
        it "should not create a new user" do
          pending
          expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Full name", with: "Kareem Grant"
        fill_in "Email", with: "sample@sample.com"
        fill_in "user_password", with: "yes"
        fill_in "Password confirmation", with: "yes"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "login" do
    before { visit login_path }
    let!(:user){ User.create(full_name: "Paul Blackwell", email: "s@s.com", password: "yolo")}
    let(:submit) { "Log In" }

    describe "with valid information" do
      before do
        fill_in "Email", with: "s@s.com"
        fill_in "Password", with: "yolo"
      end

      it "should log in a user" do
        click_button submit
        # page.should have_content("s@s.com")
        expect(current_path).to eq "/"
        expect(page).to have_link("Logout", href: logout_path)
      end
    end

    describe "with invalid information" do
      before do
        fill_in "Email", with: "A@"
        fill_in "Password", with: "yolo"
      end

      it "should not log in a user" do
        click_button submit
        expect(page).to have_link("Log In", href: login_path)
        within("div.alert") do
          expect(page).to have_content("Wrong user email and/or password")
        end
      end
    end
  end
end
