require 'spec_helper'

describe "consumers/index" do
  before(:each) do
    assign(:consumers, [
      stub_model(Consumer,
        :email => "Email",
        :billing_address_id => 1,
        :shipping_address_id => 2,
        :user_id => 3
      ),
      stub_model(Consumer,
        :email => "Email",
        :billing_address_id => 1,
        :shipping_address_id => 2,
        :user_id => 3
      )
    ])
  end

  it "renders a list of consumers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
