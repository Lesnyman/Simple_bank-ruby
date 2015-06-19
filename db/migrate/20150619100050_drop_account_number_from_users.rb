class DropAccountNumberFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :account_number
  end
end
