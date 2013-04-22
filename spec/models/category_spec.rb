require 'spec_helper'

describe Category do

  context "has a valid name" do
    let(:category){Category.new name: "Yayo"}

    it "should be valid" do
      expect(category).to be_valid
    end
  end

  context "has to be unique" do 

    before do 
      Category.create name: "Yayo"
      @duplicate_category = Category.create name: "Yayo"
    end

    it "duplicate category should not be valid" do
      expect(@duplicate_category).to be_invalid
    end
  end

  context "name is present" do
    let(:category){ Category.new name: ""}

    it "should be invalid" do
      expect(category).to be_invalid
    end
  end

  it "converts the object to a string representation" do
    category = Category.create name: "Brogrammer"
    expect(category.to_s).to eq "Brogrammer"
  end
end
