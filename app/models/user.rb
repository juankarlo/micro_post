class User < ActiveRecord::Base
  #attr_accessor :name, :email, :password, :password_confirmation

  before_save { self.email = email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX= /\A[\w+\-.]+[a-z\d\-]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX},
            uniqueness: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6 }
  validates :password_confirmation, presence: true


end
