class PaybillAccount < ApplicationRecord
  belongs_to :paybill
  has_and_belongs_to_many :users

  validates :name, uniqueness: {
    case_sensitive: false,
    scope: :paybill_id,
    message: 'An account of the same name already exists for this paybill'
  }
end
