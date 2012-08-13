require 'spec_helper'

describe Followership do

  let(:user) { FactoryGirl.create(:user) }
  let(:topic) { FactoryGirl.create(:topic) }
  let(:followership) { :user.followerships.build(topic_id: topic.id) }

  subject { followership }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Followership.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end
