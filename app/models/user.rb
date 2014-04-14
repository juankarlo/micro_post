class User < ActiveRecord::Base
  #attr_accessor :name, :email, :password, :password_confirmation
  has_many :microposts, dependent: :destroy
  extend FriendlyId
  friendly_id :slug_candidates, use: [:slugged, :finders]

  def slug_candidates
    [:name, :email]
  end

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX= /\A[\w+\-.]+[a-z\d\-]+@[a-z\d]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  #validates :password, presence: true, length: {minimum: 6}
  #validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    # TODO: This is a preliminary implementation of the feed method
    Micropost.where("user_id = ?", id)
    # Micropost.where( user_id: id)
  end

  private
  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end


end
