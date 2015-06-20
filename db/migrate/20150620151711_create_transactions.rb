class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.integer :from_account_number
      t.integer :to_account_number

      t.timestamps
    end
  end
end
