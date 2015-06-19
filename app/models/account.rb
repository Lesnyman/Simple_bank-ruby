class Account < ActiveRecord::Base
  belongs_to :user
  
  validates :account_number, length: {minimum: 4 , maximum: 4}
end
