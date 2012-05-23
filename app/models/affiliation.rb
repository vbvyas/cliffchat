class Affiliation < ActiveRecord::Base
  attr_accessible :id, :name

  has_many :users
  has_many :miniposts
end
