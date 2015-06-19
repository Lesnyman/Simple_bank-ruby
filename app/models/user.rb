class User < ActiveRecord::Base
  has_many :accounts
  
  validates :name, length: {minimum: 2 , maximum: 20}
  validates :lastname, length: {minimum: 2 , maximum: 30}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, length: {maximum: 254}, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 , maximum: 30}
  has_secure_password
end
