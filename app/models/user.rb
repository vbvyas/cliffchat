# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation, :affiliation_id

  belongs_to :affiliation
  
  has_many :miniposts, :dependent => :destroy
  has_many :responses, :dependent => :destroy
  has_many :followerships, foreign_key: "user_id", dependent: :destroy
  has_many :topics, through: :followerships
  has_many :interests, foreign_key: "user_id", dependent: :destroy
  has_many :followedposts, through: :interests
  has_many :votes, foreign_key: "user_id", dependent: :destroy
  has_many :votedresponses, through: :votes
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length => { :maximum => 50 }
  validates :email, :presence => true,
                    :format => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..40 },
                       if: :validate_password?
  validates :affiliation_id, :presence => true

  before_create { generate_token(:auth_token) }
  before_save :encrypt_password

  def validate_password?
    password.present? || password_confirmation.present?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  # Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def self.authenticate_with_salt(auth_token, cookie_salt)
    user = find_by_auth_token(auth_token)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def feed
    Minipost.where("affiliation_id = ?", affiliation_id)
  end

  def following?(topic)
    followerships.find_by_topic_id(topic.id)
  end

  def follow!(topic)
    followerships.create!(topic_id: topic.id)
  end

  def unfollow!(topic)
    followerships.find_by_topic_id(topic.id).destroy
  end

  def followingpost?(minipost)
    interests.find_by_followedpost_id(minipost.id)
  end

  def followpost!(minipost)
    interests.create!(followedpost_id: minipost.id)
  end

  def unfollowpost!(minipost)
    interests.find_by_followedpost_id(minipost.id).destroy
  end

  def votedresponse?(response)
    votes.find_by_votedresponse_id(response.id)
  end

  def voteresponse!(response)
    votes.create!(votedresponse_id: response.id)
  end

  def followinguser?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def followuser!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollowuser!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private
    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      rnd = (('A'..'Z').to_a + (0..9).to_a).shuffle[0..15].join
      secure_hash("#{Time.now.utc}--#{password}--#{rnd}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
