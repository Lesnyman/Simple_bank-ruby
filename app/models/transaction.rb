class Transaction < ActiveRecord::Base
  validates :to_account_number, presence: true
  validates :amount, presence: true
  validate :check_if_account_exist
  
  private
  def check_if_account_exist
    errors.add(:to_account_number, "is invalid") unless Account.exists?(account_number: to_account_number)
  end
end
