# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com",
      :password => "foobar",
      :password => "foobar",
      :affiliation_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

  it "should require a email" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      hash = @attr.merge(:email => address)
      User.new(hash).should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo]
    addresses.each do |address|
      hash = @attr.merge(:email => address)
      User.new(hash).should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    # Put a user with given email address into the database
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  describe "password validations" do
    
    it "should require a password" do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => "invalid")).
        should_not be_valid
    end

    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do

      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?("invalid").should be_false
      end
    end

    describe "authenticate method" do

      it "should return nil on email/password mismatch" do
        wrong_pwd_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_pwd_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user on email/password match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end

  describe "minipost associations" do

    before(:each) do
      @user = User.create(@attr)
      @mp1 = Factory(:minipost, :user => @user, :affiliation_id => @user.affiliation_id, :created_at => 1.day.ago)
      @mp2 = Factory(:minipost, :user => @user, :affiliation_id => @user.affiliation_id, :created_at => 1.hour.ago)
    end

    it "should have a miniposts attribute" do
      @user.should respond_to(:miniposts)
    end

    it "should have the right miniposts in the right order" do
      @user.miniposts.should == [@mp2, @mp1]
    end

    describe "status feed" do

      it "should have a feed" do
        @user.should respond_to(:feed)
      end

      it "should include the user's miniposts" do
        @user.feed.include?(@mp1).should be_true
        @user.feed.include?(@mp2).should be_true
      end
    end
  end

  describe "response associations" do

    before(:each) do
      @user = User.create(@attr)
      @u2 = User.create(@attr.merge(:email => "abc@example.com"))
      @mp = Factory(:minipost, :user => @user, :affiliation_id => @user.affiliation_id)
      @r0 = Factory(:response, :user => @user, :minipost => @mp)
      @r1 = Factory(:response, :user => @u2, :minipost => @mp)
      @r2 = Factory(:response, :user => @user, :minipost => @mp)
    end

    it "should have a responses attribute" do
      @user.should respond_to(:responses)
    end

    it "should have the right responses in the right order" do
      @user.responses.should == [@r0, @r2]
    end

    describe "status feed" do

      it "should include responses to miniposts" do
        @user.responses.include?(@r0).should be_true
        @u2.responses.include?(@r1).should be_true
        @user.responses.include?(@r2).should be_true
      end
    end
  end

  describe "followership associations" do
    it { should respond_to(:followerships) }
  end
end
