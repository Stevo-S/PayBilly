class C2bTransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:validate, :create]
  
  def validate
    tx = C2bTransaction.new(transaction_params)
    tx.accepted = true

    tx.save
    
    response = {
        "ResultCode": 0,
        "ResultDesc": "Accepted"
    }

    render json: response
  end

  def create
    confirmed_transaction = C2bTransaction.new(transaction_params)
    validated_transaction = C2bTransaction.find_by_trans_id(confirmed_transaction.trans_id)

    if validated_transaction then
      validated_transaction.confirmed = true
      validated_transaction.save
    else
      confirmed_transaction.accepted = false
      confirmed_transaction.confirmed = true
      confirmed_transaction.save
    end

    response = { "C2BPaymentConfirmationResult": "Success" }

    render json: response
  end

  def index
  end

  def show
  end
  
  private

  def transaction_params
    transaction_details = {}

    params.each do |name, value|
      transaction_details[name.underscore] = value
    end

    tx_params = ActionController::Parameters.new({ c2b_transaction: transaction_details })

    tx_params.require(:c2b_transaction).permit(:transaction_type, :trans_id, :trans_time, :trans_amount,
        :business_short_code, :bill_ref_number, :invoice_number, :org_account_balance,
        :third_party_trans_id, :msisdn, :first_name, :middle_name, :last_name)
  end
end