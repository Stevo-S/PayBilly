class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :paybill_accounts
  has_and_belongs_to_many :tills

  attribute :sampling_rate, :decimal, default: 0.0
  attribute :hard_sampling, :boolean, default: false
  attribute :sampling_threshold, :integer, default: 1000
end
