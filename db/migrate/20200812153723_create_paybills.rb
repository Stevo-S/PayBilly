class CreatePaybills < ActiveRecord::Migration[6.0]
  def change
    create_table :paybills do |t|
      t.string :paybill_number
      t.string :consumer_key
      t.string :consumer_secret
      t.string :validation_url
      t.string :confirmation_url
      t.datetime :last_registration_date
      t.boolean :last_registration_succeeded
      t.integer :last_registration_response_code, limit: 2
      t.text :last_registration_response

      t.timestamps
    end
  end
end
