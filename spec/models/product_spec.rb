require 'spec_helper'

describe 'Products:' do

  before :each do
    Store.create(name: 'test store', description: 'store for testing', path: 'test_store')
  end

  context 'when a product is created' do
    it 'it is valid if all required attributes are given' do
      product = Product.new(title: 'title', description: 'description', auction_id: 1)
      expect(product.valid?).to eq true
    end

    it 'it is invalid without a title' do
      product = Product.new(description: 'description', auction_id: 1)
      expect(product.valid?).to eq false
    end

    it 'it is invalid when the title is duplicated' do
      Product.create(title: 'title', description: 'description', auction_id: 1)
      product = Product.new(title: 'title', description: 'description', auction_id: 1)
      expect(product.valid?).to eq false
    end

    it 'it is invalid without a description' do
      product = Product.new(title: 'title', auction_id: 1)
      expect(product.valid?).to eq false
    end
  end

  context '.status' do
    it 'returns active when a product is active' do
      product = Product.new(title: 'title', description: 'description', auction_id: 1, active: true)
      expect(product.status).to eq 'active'

    end

    it 'returns retired when a product is retired' do
      product = Product.new(title: 'title', description: 'description', auction_id: 1, active: false)
      expect(product.status).to eq 'retired'
    end
  end

  context '.to_s' do
    it 'returns the title of the product it is called on' do
      product = Product.new(title: 'title', description: 'description', auction_id: 1)
      expect(product.to_s).to eq 'title'
    end
  end

  context '.categories_list' do
    it 'shows a comma separated list of categories the product belongs to' do
      product = Product.create(title: 'title', description: 'description', auction_id: 1)
      category1 = Category.create(name: 'test1')
      ProductCategory.create(product_id: product.id, category_id: category1.id)
      category2 = Category.create(name: 'test2')
      ProductCategory.create(product_id: product.id, category_id: category2.id)
      expect(product.categories_list).to eq 'test1, test2'
    end
  end

end
