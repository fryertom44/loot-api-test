class CreateTransfers < ActiveRecord::Migration[5.1]
  def change
    create_table :transfers do |t|
      t.string :account_number_from, limit: 18
      t.string :account_number_to, limit: 18
      t.integer :amount_pennies
      t.string :country_code_from, limit: 3
      t.string :country_code_to, limit: 3
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
