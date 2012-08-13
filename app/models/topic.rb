class Topic < ActiveRecord::Base
  attr_accessible :name

  has_and_belongs_to_many :miniposts
  has_many :followerships
  has_many :users, through: :followerships
end
