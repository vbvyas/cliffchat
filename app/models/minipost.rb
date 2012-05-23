class Minipost < ActiveRecord::Base
  attr_accessible :content, :affiliation_id

  belongs_to :user
  belongs_to :affiliation

  has_many :responses

  validates :content, :presence => true, :length => { :maximum => 150 }
  validates :user_id, :presence => true
  validates :affiliation_id, :presence => true

  default_scope :order => 'miniposts.created_at DESC'
end
