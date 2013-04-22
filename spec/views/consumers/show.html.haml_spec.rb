require 'spec_helper'

describe "consumers/show" do
  before(:each) do
    @consumer = assign(:consumer, stub_model(Consumer,
      :email => "Email",
      :billing_address_id => 1,
      :shipping_address_id => 2,
      :user_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
