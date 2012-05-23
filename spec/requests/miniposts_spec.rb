require 'spec_helper'

describe "Miniposts" do

  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email, :with => user.email
    fill_in :password, :with => user.password
    click_button
  end

  describe "creation" do

    describe "failure" do

      it "should not make a new minipost" do
        lambda do
          visit root_path
          fill_in :minipost_content, :with => ""
          click_button "Submit"
          response.should render_template('pages/home')
          response.should have_selector("div#error_explanation")
        end.should_not change(Minipost, :count)
      end
    end

    describe "success" do

      it "should make a new minipost" do
        content = "Lorem ipsum dolor sit amet"
        lambda do
          visit root_path
          fill_in :minipost_content, :with => content
          click_button "Submit"
          response.should have_selector("span.content", :content => content)
        end.should change(Minipost, :count).by(1)
      end
    end
  end
end
