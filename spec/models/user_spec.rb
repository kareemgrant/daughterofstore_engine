require 'spec_helper'

describe User do

  context "when there is no name" do
    let(:user){ User.new email: "s@s.com", password: "yes" }

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:full_name)
    end
  end

  context "when there is no email" do
    let(:user){ User.new full_name: "Kareem", password: "yes" }

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:email)
    end
  end

  context "when there is no password" do
    let(:user){ User.new full_name: "Kareem", email: "s@s.com" }

    it "is invalid" do
      expect(user).to be_invalid
    end

    it "has errors" do
      expect(user).to have(1).errors_on(:password)
    end
  end

  context "happy path" do
    let(:user){ User.new full_name: "Kareem", email: "s@s.com", password: "yes" }

    it "is valid" do
      expect(user).to be_valid
    end

    it "has no errors" do
      expect(user).to have(0).errors
    end
  end

  context "validate unique email" do
  
    before(:each) do
      @user1 = User.create full_name: "Paul", email: "s@s.com", password: "yolo"
      @user2 = User.create full_name: "Paul", email: "s@s.com", password: "hello"
    end
    
    it "is invalid" do
      expect(@user2).to be_invalid
    end

    it "has an error" do
      expect(@user2).to have(1).errors
    end
  end
end
