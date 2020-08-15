class AddSamplingToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sampling_rate, :decimal, precision: 4, scale: 2
    add_column :users, :hard_sampling, :boolean
  end
end
