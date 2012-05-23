require 'spec_helper'

describe Minipost do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
    m = @user.miniposts.build(@attr)
    m.affiliation_id = @user.affiliation_id
    m.save
  end

  describe "user associations" do

    before(:each) do
      @minipost = @user.miniposts.create(@attr)
    end

    it "should have a user attribute" do
      @minipost.should respond_to(:user)
    end

    it "should have the right associated user" do
      @minipost.user_id.should == @user.id
      @minipost.user.should == @user
    end
  end

  describe "response associations" do

    before(:each) do
      @minipost = @user.miniposts.create(@attr)
    end

    it "should have a response attribute" do
      @minipost.should respond_to(:responses)
    end
  end

  describe "validations" do

    it "should require a user id" do
      Minipost.new(@attr).should_not be_valid
    end

    it "should require non-blank content" do
      @user.miniposts.build(:content => "   ").should_not be_valid
    end

    it "should reject long content" do
      @user.miniposts.build(:content => "a" * 151).should_not be_valid
    end
  end
end
