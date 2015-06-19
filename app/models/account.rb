class Account < ActiveRecord::Base
  belongs_to :user
  
  validates :user, presence: true
  validates :account_number, length: {minimum: 4 , maximum: 4}, uniqueness: true
end
