class AddSamplingThresholdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :sampling_threshold, :integer
  end
end
