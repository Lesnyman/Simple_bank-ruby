class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user_id, index: true, foreign_key: true
      t.integer :cash
      t.integer :account_number

      t.timestamps
    end
  end
end
