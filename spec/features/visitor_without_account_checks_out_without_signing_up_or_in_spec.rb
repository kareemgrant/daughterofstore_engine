require 'spec_helper'

feature 'Visitor checks out without signing up or signing in' do
  context "Given I am a visitor to the store '/hats' And I have added items to my cart" do
    context "when I checkout" do
      it 'I can provide my email billing, shipping and cc info to purchase directly' do
        visit "/hats"
        page.should have_content("Mobster Hat")
        page.should have_link("Mobster Hat")
        click_link("Mobster Hat")
        current_path.should == "/hats/products/mobster-hat"
        page.should have_button "Add to Cart"
        click_button "Add to Cart"
        current_path.should == "/hats/products/mobster-hat"
        page.should have_link "My Cart"
        click_link "My Cart"
        current_path.should include("/hats/carts/")
        page.should have_button "Checkout"
        click_button "Checkout"
        current_path.should == "/login"
        page.should have_button "Checkout as Guest"
        click_button "Checkout as Guest"
        fill_in "guest_email", :with => "derpaderp@lulz.com"
        fill_in "guest_billing_address", :with => "123 Happy-Fuck Lane"
        fill_in "guest_shipping_address", :with => "6969 Suck-dik Road"
        page.should have_button "Purchase"
        click_link "Purchase"
      end

      it 'then I am shown a confirmation page with a unique, hashed URL that displays my order details' do
        visit "/hats"
        page.should have_content("Mobster Hat")
        page.should have_link("Mobster Hat")
        click_link("Mobster Hat")
        current_path.should == "/hats/products/mobster-hat"
        page.should have_button "Add to Cart"
        click_button "Add to Cart"
        current_path.should == "/hats/products/mobster-hat"
        page.should have_link "My Cart"
        click_link "My Cart"
        current_path.should include("/hats/carts/")
        page.should have_button "Checkout"
        click_button "Checkout"
        current_path.should == "/login"
        page.should have_button "Checkout as Guest"
        click_button "Checkout as Guest"
        fill_in "guest_email", :with => "derpaderp@lulz.com"
        fill_in "guest_billing_address", :with => "123 Happy-Fuck Lane"
        fill_in "guest_shipping_address", :with => "6969 Suck-dik Road"
        page.should have_button "Purchase"
        click_link "Purchase"
        current_path.should include("order_details")
        page.should have_content "Mobster Hat"
      end
    end
  end
end
