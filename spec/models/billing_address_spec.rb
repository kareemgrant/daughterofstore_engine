require 'spec_helper'

describe BillingAddress do
  
  context "has a valid street" do
    let(:billing_address){BillingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210", :order_id => 1}

    it "should be valid" do
      expect(billing_address).to be_valid
    end
  end

  context "has a valid city" do
    let(:billing_address){BillingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(billing_address).to be_valid
    end
  end

  context "has a valid state" do
    let(:billing_address){BillingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(billing_address).to be_valid
    end
  end

  context "has a valid zipcode" do
    let(:billing_address){BillingAddress.new street: "415 Bluebird Lane", city: "Beverly Hills", state: "California", zipcode: "90210"}

    it "should be valid" do
      expect(billing_address).to be_valid
    end
  end
end
