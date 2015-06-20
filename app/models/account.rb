class Account < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :account_number, length: {minimum: 4 , maximum: 4}, uniqueness: true
  
  def self.create_accout_for_new_user(user)
    max = Account.maximum("account_number")
    if max == nil
      max = 1000
    elsif max < 1000
      max = 1000
    else
      max =  max+1
    end
    Account.create!(user_id: User.find(user).id,
                    cash: 100,
                    account_number: max)
  end
end
