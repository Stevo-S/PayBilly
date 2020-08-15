ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :email, :password, :password_confirmation, :sampling_threshold,
    :sampling_rate, :hard_sampling, paybill_account_ids: [], till_ids: [] 

  form do |f|
    f.inputs "User Details" do
      f.inputs :name
      f.inputs :email
      if f.object.new_record?
        f.inputs :password
        f.inputs :password_confirmation
      end
    
      f.input :sampling_rate
      f.input :hard_sampling
      f.input :sampling_threshold

      f.input :tills, as: :check_boxes, collection: Till.pluck(:till_number, :id)

      f.inputs "Paybill Accounts" do
        Paybill.all.each do |paybill|
          f.input :paybill_accounts, as: :check_boxes, label: paybill.paybill_number,
            collection: paybill.paybill_accounts
        end
      end
    end
    
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :encrypted_password
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :failed_attempts
      row :unlock_token
      row :locked_at
      row :sampling_rate
      row :hard_sampling
      row :sampling_threshold

      row "Tills" do |u|
        (u.tills.map{ |t| t.till_number }).join(', ')
      end

      # TODO: Find a better way to visually present this information
      row "Paybill" do 
        "ACCOUNTS" 
      end
      user.paybill_accounts.collect { |p| p.paybill }.uniq.each do |p|
        row "Paybill: #{p.paybill_number}" do
          user.paybill_accounts.where(paybill_id: p.id).
            map { |acc| acc.name }.join(', ')
        end
      end

      row :created_at
      row :updated_at
    end
  end
end
