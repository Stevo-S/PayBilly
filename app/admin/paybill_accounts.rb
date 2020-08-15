ActiveAdmin.register PaybillAccount do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :paybill_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :paybill_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :paybill_id

  form do |f|
    f.inputs do
      f.input :paybill, as: :select, collection: Paybill.all.collect {|s| [s.paybill_number, s.id]}
      f.input :name
    end

    f.actions
  end

  show do
    attributes_table do
      row :name
      row :paybill do |account|
        account.paybill.paybill_number
      end
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  index do
    selectable_column
    id_column
    column :name
    column :paybill do |account|
      account.paybill.paybill_number
    end
    column :created_at
    column :updated_at
  end
end
