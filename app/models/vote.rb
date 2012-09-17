class Vote < ActiveRecord::Base
  attr_accessible :user_id, :votedresponse_id

  belongs_to :user
  belongs_to :votedresponse, class_name: "Response"

  validates :user_id, presence: true
  validates :votedresponse_id, presence: true
end
