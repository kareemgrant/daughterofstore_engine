require 'spec_helper'
require 'capybara/rspec'

describe 'Search:' do

  context 'when a user searches for an auction by product title' do

    let!(:store) {Store.create(name: 'Spacely Sprockets',
                               path: 'spacely-sprockets',
                               description: 'For those who like rusty stuff from junkyards',
                               status: 'online')}

    let!(:auction1) {Auction.create(store_id: store.id,
                                    expiration_date: Time.new(2012, 04, 30),
                                    starting_bid: 0,
                                    shipping_options: 'International',
                                    active: true)}

    let!(:auction2) {Auction.create(store_id: store.id,
                                    expiration_date: (Time.now + 86400),
                                    starting_bid: 0,
                                    shipping_options: 'International',
                                    active: true)}

    let!(:product1) {Product.create(auction_id: 1,
                                    title: 'Rusty Rocket Ship',
                                    description: 'This old lady was the prototype for Apollo 11. I stole her from NASA after they threw in a junkyard. I bet this baby is worth millions',
                                    active: true)}

    let!(:product2) {Product.create(auction_id: 2,
                                    title: 'Rusty Bicycle',
                                    description: 'My grandaddy rode this bad boy to and from school, uphill both ways, in the snow.',
                                    active: true)}

    it 'they are directed to an auction index page showing all products that match the search criteria' do
      visit '/'
      fill_in 'search', with: 'Rusty'
      click_button 'Search'
      expect(current_path).to eq(products_path)
      page.should have_content 'My grandaddy rode this bad boy'
      page.should have_content 'This old lady was the prototyp'
    end

    it 'they are directed to an auction index page showing all products that match the search criteria' do
      visit '/'
      fill_in 'search', with: 'Rusty Bicycle'
      click_button 'Search'
      expect(current_path).to eq(products_path)
      page.should have_content 'My grandaddy rode this bad boy'
      page.should_not have_content 'This old lady was the prototyp'
    end
  end
end