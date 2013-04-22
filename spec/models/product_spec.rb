require 'spec_helper'

describe Product do

  context "missing title" do
    let(:product){Product.new description: "ipsum mormon", price_in_dollars: 12.95}

    it "is invalid" do
      expect(product).to be_invalid
    end

    it "has errors" do
      expect(product).to have(1).errors_on(:title)
    end
  end
  context "missing description" do
    let(:product){Product.new title: "cheeseburgers", price_in_dollars: 99.95}

    it "is invalid " do
      expect(product).to be_invalid
    end

    it "has errors" do
      expect(product).to have(1).errors_on(:description)
    end
  end

  context "missing price" do
    let(:product){Product.new title: "cheeseburgers", description: "I love cheesburgers"}

    it "is invalid" do
      expect(product).to be_invalid
    end

    it "has errors" do
      expect(product).to have(1).errors_on(:price)
    end
  end

  context "happy path" do
    let(:product){Product.new title: "mormon cheeseburgers", description: "ipsum mormon", price_in_dollars: 10.13}

    it "is valid" do
      expect(product).to be_valid
    end

    it "has 0 errors" do
      expect(product).to have(0).errors
    end
  end

  context "validates uniqueness" do
    let!(:product){Product.create title: "mormon cheeseburgers", description: "ipsum mormon", price_in_dollars: 10.13}
    let!(:product2){Product.create title: "mormon cheeseburgers", description: "ipsum mormon", price_in_dollars: 10.13}

    it "validates uniqueness of title" do
      expect(product2).to have(1).error
    end
  end

  it "returns whether or not a product is active" do
    product = Product.new title: "mormon cheeseburgers", description: "ipsum mormon", price_in_dollars: 10.13, active: false
    expect(product.status).to eq("retired")
  end

  it "renders the name in a readable format" do
    product = Product.new title: "mormon cheeseburgers", description: "ipsum mormon", price_in_dollars: 10.13, active: false
    expect(product.to_s).to eq "mormon cheeseburgers"
  end

  it "joins categories" do
    product = Product.create(title: "mormon cheeseburgers", description: "ipsum mormon", price_in_dollars: 10.13)
    category1 = Category.create(name: "cheeseburger")
    category2 = Category.create(name: "yum")
    pc1 = ProductCategory.create(product_id: product.id, category_id: category1.id)
    pc2 = ProductCategory.create(product_id: product.id, category_id: category2.id)
    expect(product.categories_list).to eq("cheeseburger, yum")
  end
end
