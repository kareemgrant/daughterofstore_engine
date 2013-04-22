require 'spec_helper'

describe ShippingAddress do

 context "has a valid street" do
    let(:shipping_address){ShippingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(shipping_address).to be_valid
    end
  end

  context "has a valid city" do
    let(:shipping_address){ShippingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(shipping_address).to be_valid
    end
  end

  context "has a valid state" do
    let(:shipping_address){ShippingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(shipping_address).to be_valid
    end
  end

  context "has a valid zipcode" do
    let(:shipping_address){ShippingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(shipping_address).to be_valid
    end
  end 
end
