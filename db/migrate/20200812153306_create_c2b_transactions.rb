class CreateC2bTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :c2b_transactions do |t|
      t.string :transaction_type
      t.string :trans_id
      t.string :trans_time
      t.string :trans_amount
      t.string :business_short_code
      t.string :bill_ref_number, limit: 20
      t.string :invoice_number
      t.string :org_account_balance
      t.string :third_party_trans_id
      t.string :msisdn, limit: 12
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.boolean :accepted
      t.boolean :confirmed

      t.timestamps
    end
    add_index :c2b_transactions, :trans_id
  end
end
