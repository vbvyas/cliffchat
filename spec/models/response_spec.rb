require 'spec_helper'

describe Response do

  before(:each) do
    @user = Factory(:user)
    @minipost = Factory(:minipost, :user => @user)
    @attr = { :content => "response value" }
  end

  it "should create a new response given valid attributes" do
    response = @user.responses.create!(@attr)
    @minipost.responses << response
  end

  describe "user and minipost associations" do

    before(:each) do
      @minipost = @user.miniposts.create(@attr)
      @response = @user.responses.create(@attr)
      @minipost.responses << @response
    end

    it "should have a user attribute" do
      @response.should respond_to(:user)
    end

    it "should have the right associated user" do
      @response.user_id.should == @user.id
      @response.user.should == @user
    end

    it "should have a minipost attribute" do
      @response.should respond_to(:minipost)
    end

    it "should have the right associated minipost" do
      @response.minipost_id.should == @minipost.id
      @response.minipost == @minipost
    end
  end

  describe "validations" do

    it "should require a user id" do
      Response.new(@attr).should_not be_valid
    end

    it "should require non-blank content" do
      @user.responses.build(@attr.merge(:content => "  ")).should_not be_valid
    end

    it "should reject long content" do
      @user.responses.build(@attr.merge(:content => "a" * 151)).should_not be_valid
    end
  end
end
