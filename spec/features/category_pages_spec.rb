require 'spec_helper'
require 'capybara/rspec'

describe "Category pages" do
  subject { page }

  
  # describe "Creating a category" do
  #   before { visit new_category_path }

  #   describe "with invalid information" do

  #     it "should not create a new category" do
  #       expect { click_button "submit" }.not_to change(Category, :count)
  #     end

  #     it "should display error message" do
  #       click_button "submit"
  #       page.should have_content("prohibited")
  #     end

  #   end

  #   describe "with valid information" do

  #     it "should increase Category count" do
  #       fill_in "Name", with: "Anything"
  #       expect { click_button "submit"}.to change(Category, :count)
  #     end

  #   end

  # end

  describe "Viewing list of categories" do

    let!(:category){ Category.create(name: "Beards")}

    before { visit categories_path }
      
    describe "content on index page" do
      it "should have delete links for each category listed" do
        page.should have_content("Beards")
      end
    end
  end

  describe "Viewing a specific category" do
    let!(:category){ Category.create(name: "Beards")}
    let!(:product){ Product.create(title: "Karl Marx beard", description: "It's Red!", price_in_dollars: 20.05)}
    let!(:product_category){ ProductCategory.create(product_id: (product.id), category_id: (category.id))}

    it "has a list of related products" do
      visit category_path(category)
      page.should have_link("Karl Marx beard")
    end
  end

  # describe "When editing a category" do

  #   let!(:category){Category.create(name: "Capybara")}

  #   before { visit edit_category_path(category) }

  #   it "successfully updates the category" do
  #     fill_in "Name", with: "Kareem"
  #     click_button "submit"
  #     page.should have_content("Kareem")
  #   end
  # end


  # describe "Deletes category" do

  #   let!(:category){Category.create(name: "Capybara")}

  #   before { visit categories_path }
end
