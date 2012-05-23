require 'spec_helper'

describe ResponsesController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @minipost = Minipost.first || Factory.create(:minipost, :user => @user)
      Minipost.stub(:find) { @minipost }
    end

    describe "failure" do

      before(:each) do
        @attr = { :content => "" }
      end

      it "should not create a response" do
        lambda do
          post :create, :response => @attr, :minipost => @minipost
        end.should_not change(Response, :count)
      end

      it "should render the home page" do
        post :create, :response => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :content => "Lorem ipsum" }
      end

      it "should create a response" do
        lambda do
          post :create, :response => @attr
        end.should change(Response, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :response => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :response => @attr
        flash[:success].should =~ /response created/i
      end
    end
  end

  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @minipost = Factory(:minipost, :user => @user)
        @r = Factory(:response, :user => @user, :minipost => @minipost)
      end

      it "should deny access" do
        delete :destroy, :id => @r
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @minipost = Factory(:minipost, :user => @user)
        @r = Factory(:response, :user => @user, :minipost => @minipost)
      end

      it "should destroy the response" do
        lambda do
          delete :destroy, :id => @r
        end.should change(Response, :count).by(-1)
      end
    end
  end
end
