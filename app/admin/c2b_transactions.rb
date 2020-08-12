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
  
end
