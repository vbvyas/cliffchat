class Followership < ActiveRecord::Base
  attr_accessible :user_id, :topic_id

  belongs_to :user
  belongs_to :topic

  validates :user_id, presence: true
  validates :topic_id, presence: true
end
