require 'spec_helper'

describe User do

  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  it "should not be valid without a full name" do
    expect(build(:user, full_name: nil)).to have(1).errors_on(:full_name)
  end

  it "should not be valid without a email" do
    expect(build(:user, email: nil)).to have(1).errors_on(:email)
  end

  it "should not be valid without a password" do
    expect(build(:user, password: nil)).to have(1).errors_on(:password)
  end

  it "is invalid with a duplicate email address" do
    create(:user, email: "ironman@example.com")
    user = build(:user, email: "ironman@example.com")
    expect(user).to have(1).errors_on(:email)
  end

  it "should have an array of stores" do
    user = create(:user)
    expect(user.stores.class).to eq Array
  end

end
