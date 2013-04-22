require 'spec_helper'

describe Cart do


  it { should validate_presence_of(:store_id) }
  it { should belong_to(:store) }

  it "is not empty" do
    cart = Cart.create
    line_item1 = LineItem.create(product_id: 1, cart_id: cart.id)
    expect(cart.empty?).to be_false
  end

  it "can add_product" do
    cart = Cart.create(:store_id => 999)
    expect(cart.empty?).to eq true
    line_item1 = LineItem.create(product_id: 1, cart_id: cart.id)
    cart.add_product(line_item1.product_id)
    expect(cart.empty?).to be_false
    expect(cart.line_items.count).to eq 1
  end

  it "can increase_quantity(product_id)" do
    cart = Cart.create(:store_id => 999)
    line_item1 = LineItem.create(product_id: 999, cart_id: cart.id)
    cart.increase_quantity(999)
    cart.increase_quantity(999)
    count = Hash.new(0)
    cart.line_items.each do |c|
      count[:i] += c.quantity
    end 
    expect(count[:i]).to eq 3
  end

  it "can decrease_quantity(product_id)" do
    cart1 = Cart.create(:store_id => 6969)
    line_item1 = LineItem.create(product_id: 6969, cart_id: cart1.id)
    cart1.decrease_quantity(6969)
    cart1.decrease_quantity(6969)
    count = Hash.new(0)
    cart1.line_items.each do |c|
      count[:i] += c.quantity
    end 
    expect(count[:i]).to eq -1
  end

  it "can determine emptiness" do
    cart = Cart.create(:store_id => 6969)
    (cart.empty?).should == true
  end

  it "can determine todal price" do
    cart = Cart.create(:store_id => 6969)
    expect(cart.total_price).to eq 0
  end
end
