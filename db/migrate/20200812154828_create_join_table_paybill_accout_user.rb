class CreateJoinTablePaybillAccoutUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :paybill_accounts, :users do |t|
      t.index [:paybill_account_id, :user_id]
      t.index [:user_id, :paybill_account_id]
    end
  end
end
