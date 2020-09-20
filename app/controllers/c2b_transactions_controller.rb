class C2bTransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:validate, :create]
  
  before_action :authenticate_user!, only: [:show, :index]
  
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
    page = params[:page]
    per_page = params[:per_page]
    @q = C2bTransaction.ransack(params[:q])
    @q.created_at_gteq = Date.today.midnight unless params[:q]
    @q.sorts = 'updated_at desc'
    @transactions = @q.result(distinct: true).accessible_by(current_ability).page params[:page]

    if params[:q].nil? then
        params[:q] = { created_at_gteq: Date.today.midnight.strftime('%FT%T'),
        created_at_lteq: Date.tomorrow.strftime('%FT%T'), active_eq: true }
    end

    @total_count = @transactions.total_count

    if @total_count > current_user.sampling_threshold then
      @total_count = (@transactions.total_count * (current_user.sampling_rate / 100)).to_i unless
        current_user.sampling_rate <= 0 || current_user.sampling_rate > 99.9
    
      if current_user.hard_sampling then
        @transactions = @transactions.limit(@transactions.total_count)
      end
    end
  end

  def show
    @c2b_transaction = C2bTransaction.find(params[:id])
    authorize! :read, @c2b_transaction
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
