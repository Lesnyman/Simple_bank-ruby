class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.integer :cash
      t.integer :account_number

      t.timestamps
    end
  end
end
