require 'spec_helper'
require 'capybara'

describe "Order pages" do
  describe "Redirecting a logged-in customer to checkout" do
    before do
      user = User.create(full_name: "Erin", email: "e@e.com", password: "yes", password_confirmation: "yes")
      product = Product.create(title: "Mustache", description: "I mustache you a question.", price_in_dollars: 5.99)
      user2 = User.create(full_name: "Brock", email: "b@b.com", password: "yes", password_confirmation: "yes")
      @product2 = Product.create(title: "Stache", description: "I mustache you a question.", price_in_dollars: 5.99)
      visit login_path
      fill_in "Email", with: "e@e.com"
      fill_in "Password", with: "yes"
      click_button "Log In"
      visit product_path(product)
    end

    context "with items in the customer's cart" do
      it "redirects the customer to the checkout page" do
        click_button("Add to Cart")
        click_button("Checkout")
        expect(page).to have_content "Please enter your details"
      end
    end

    context "with no items in the customer's cart" do
      it "does not let the customer proceed to the checkout page" do
        click_button("cart_link")
        click_button("Checkout")
        expect(page).to have_content("Your cart is currently empty.")
      end
    end

    context "with valid information at checkout" do
      it "displays the customer's order" do
        pending
        click_button("Add to Cart")
        click_button("Checkout")
        fill_in "Street", with: "123 A"
        fill_in "City", with: "yes"
        fill_in "State", with: "DC"
        fill_in "Zip", with: 44101
        expect{ click_button("Place Order") }.to change(Order, :count).by(1)
      end
    end

    it "displays only the customer's past orders" do
      click_button("Add to Cart")
      click_button("Checkout")
      click_link("Logout")
      visit login_path
      fill_in "Email", with: "b@b.com"
      fill_in "Password", with: "yes"
      click_button "Log In"
      visit product_path(@product2)
      click_button("Add to Cart")
      click_button("Checkout")
      visit orders_path
      expect(page).to_not have_content("Erin")
    end
  end

  describe "Redirecting a non-logged in user to log in before checkout" do
    let!(:product){ Product.create(title: "Mustache", description: "I mustache you a question.", price_in_dollars: 5.99) }

    it "does not let the user proceed to the checkout page" do
      visit product_path(product)
      click_button("Add to Cart")
      click_button("Checkout")
      expect(page).to have_content("You must be logged in")
    end
  end

  describe "a valid processed order" do
    before do
      user = User.create(full_name: "Erin", email: "e@e.com", password: "yes", password_confirmation: "yes")
      product = Product.create(title: "Mustache", description: "I mustache you a question.", price_in_dollars: 5.99)
      user2 = User.create(full_name: "Brock", email: "b@b.com", password: "yes", password_confirmation: "yes")
      @product2 = Product.create(title: "Stache", description: "I mustache you a question.", price_in_dollars: 5.99)
      visit login_path
      fill_in "Email", with: "e@e.com"
      fill_in "Password", with: "yes"
      click_button "Log In"
      visit product_path(product)
    end

    it "processes the order" do
      click_button("Add to Cart")
      click_button("Checkout")
      fill_in "Credit Card Number", with: 4242424242424242
      fill_in "Security Code on Card (CVV)", with: 111
      page.select("7 - July", :from => "Card Expiration")
      click_button "Create Order"
      expect(page).to have_content("Erin")
    end
  end
end