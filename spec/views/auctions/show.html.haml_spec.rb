require 'spec_helper'

describe "auctions/show" do
  before(:each) do
    @auction = assign(:auction, stub_model(Auction))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
