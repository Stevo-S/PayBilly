class CreateJoinTableTillUser < ActiveRecord::Migration[6.0]
  def change
    create_join_table :tills, :users do |t|
      t.index [:till_id, :user_id]
      t.index [:user_id, :till_id]
    end
  end
end
