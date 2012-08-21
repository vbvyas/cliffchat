class Interest < ActiveRecord::Base
  attr_accessible :user_id, :followedpost_id

  belongs_to :user
  belongs_to :followedpost, class_name: "Minipost"

  validates :user_id, presence: true
  validates :followedpost_id, presence: true
end
