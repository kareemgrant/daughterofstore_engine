require 'spec_helper'

describe "consumers/new" do
  before(:each) do
    assign(:consumer, stub_model(Consumer,
      :email => "MyString",
      :billing_address_id => 1,
      :shipping_address_id => 1,
      :user_id => 1
    ).as_new_record)
  end

  it "renders new consumer form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", consumers_path, "post" do
      assert_select "input#consumer_email[name=?]", "consumer[email]"
      assert_select "input#consumer_billing_address_id[name=?]", "consumer[billing_address_id]"
      assert_select "input#consumer_shipping_address_id[name=?]", "consumer[shipping_address_id]"
      assert_select "input#consumer_user_id[name=?]", "consumer[user_id]"
    end
  end
end
