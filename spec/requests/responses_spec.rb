require 'spec_helper'

describe "Responses" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email #"lorem@ipsum.com"
    fill_in :password, :with => user.password
    click_button "Sign in"
    visit root_path
    minipost = Factory(:minipost, :user => user)
    fill_in :minipost_content, :with => "Value for content"
    click_button "Submit"
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new response" do
        lambda do
          visit root_path
          fill_in :response_content, :with => ""
          click_button "Respond"
          response.should render_template('pages/home')
        end.should_not change(Response, :count)
      end
    end

    describe "success" do

      it "should create a new response" do
        content = "Lorem ipsum"
        lambda do
          visit root_path
          fill_in :response_content, :with => content
          click_button "Respond"
          response.should have_selector("span.content", :content => content)
        end.should change(Response, :count).by(1)
      end
    end
  end
end
