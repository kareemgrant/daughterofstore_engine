require 'spec_helper'

describe Bid do

  it "exists" do
    @bid = Bid.new
    expect(bid).to be_kind_of Bid
  end
end