require 'spec_helper'

describe "auctions/index" do
  before(:each) do
    assign(:auctions, [
      stub_model(Auction),
      stub_model(Auction)
    ])
  end

  it "renders a list of auctions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
