class PaybillAccount < ApplicationRecord
  belongs_to :paybill
  has_and_belongs_to_many :users
end
