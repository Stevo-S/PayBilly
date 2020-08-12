class CreatePaybillAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :paybill_accounts do |t|
      t.string :name
      t.references :paybill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
