class Response < ActiveRecord::Base
  attr_accessible :content

  belongs_to :user
  belongs_to :minipost

  validates :content, :presence => true, :length => { :maximum => 150 }
  validates :user_id, :presence => true

  default_scope :order => 'responses.created_at'
end
