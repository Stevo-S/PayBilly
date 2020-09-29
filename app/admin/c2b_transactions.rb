ActiveAdmin.register C2bTransaction do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :transaction_type, :trans_id, :trans_time, :trans_amount, :business_short_code, :bill_ref_number, :invoice_number, :org_account_balance, :third_party_trans_id, :msisdn, :first_name, :middle_name, :last_name, :accepted, :confirmed
  #
  # or
  #
  # permit_params do
  #   permitted = [:transaction_type, :trans_id, :trans_time, :trans_amount, :business_short_code, :bill_ref_number, :invoice_number, :org_account_balance, :third_party_trans_id, :msisdn, :first_name, :middle_name, :last_name, :accepted, :confirmed]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # TEMPORARY: REMOVE BEFORE PUSHING TO PRODUCTION!!!!!
  config.per_page = 5
  
  index do
    id_column
    column :transaction_type
    column :trans_id
    column :trans_time
    column :trans_amount
    column :business_short_code
    column :bill_ref_number
    column :invoice_number
    column :org_account_balance
    column :third_party_trans_id
    column :msisdn
    column :first_name
    column :middle_name
    column :last_name
    column :accepted
    column :confirmed
    column :created_at

    # actions defaults: false do |tx|
    #   item "View", admin_c2b_transaction_path(tx)
    # end

    div class: "panel" do
      h2 "Total amount: Kshs. "\
      "#{number_with_precision(C2bTransaction.search(params[:q]).result.
                                  pluck(:trans_amount).map(&:to_d).reduce(:+), 
                                :precision => 2, 
                                :delimiter => ','
        )
      }"
    end
  end
end
