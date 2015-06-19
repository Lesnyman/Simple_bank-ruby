class User < ActiveRecord::Base
  has_many :accounts
  
  validates :name, length: {minimum: 2 , maximum: 20}
  validates :lastname, length: {minimum: 2 , maximum: 30}
end
