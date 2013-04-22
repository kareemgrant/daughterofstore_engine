require 'spec_helper'

feature 'Given a store named "Hats" with URL id "hats"' do
  context 'And the store has a product named "Mobster Hat"' do
    it 'does not have a product from /glasses called "Professer Glasses"' do
      visit '/hats'
      page.should have_content("Mobster Hat")
      current_path.should == "/hats"
      current_path.should_not == "/glasses"
      page.should_not have_content("Professer Glasses")
    end
  end
end
