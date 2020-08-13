ActiveAdmin.register Till do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :till_number, :consumer_key, :consumer_secret, :validation_url, :confirmation_url, :last_registration_date, :last_registration_succeeded, :last_registration_response_code, :last_registration_response
  #
  # or
  #
  # permit_params do
  #   permitted = [:till_number, :consumer_key, :consumer_secret, :validation_url, :confirmation_url, :last_registration_date, :last_registration_succeeded, :last_registration_response_code, :last_registration_response]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :till_number, :validation_url, :confirmation_url, :consumer_key, :consumer_secret

  form do |f|
    f.inputs do
      f.input :till_number
      f.input :consumer_key
      f.input :consumer_secret
      f.input :validation_url
      f.input :confirmation_url
    end

    f.actions
  end

  member_action :register_urls, method: :get do
    mpesa_base_url = ENV['MPESA_BASE_URL']

    access_token = Rails.cache.fetch("#{resource.id}/token", expires_in: 59.minutes, skip_nil: true) do
        token_generation_path = '/oauth/v1/generate'
        params = { grant_type: :client_credentials }

        url = URI("#{mpesa_base_url}#{token_generation_path}")
        url.query = URI.encode_www_form(params)

        token_request = Net::HTTP::Get.new(url)
        token_request.basic_auth resource.consumer_key, resource.consumer_secret
        token_request.content_type = 'application/json'

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true if url.scheme == "https"
        
        token_response = http.request token_request
        JSON.parse(token_response.body)["access_token"]
    end

    url_registration_path = '/mpesa/c2b/v1/registerurl'

    url = URI("#{mpesa_base_url}#{url_registration_path}")
    registration_request = Net::HTTP::Post.new(url)
    
    registration_request.content_type = 'application/json'
    registration_request['Authorization'] = "Bearer #{access_token}"
    
    registration_request.body = {
      short_code: resource.till_number,
      response_type: 'Cancelled',
      confirmation_u_r_l: resource.confirmation_url,
      validation_u_r_l: resource.validation_url
    }.to_json

    http = Net::HTTP.new(url.host, url.port)
	  http.use_ssl = true if url.scheme == "https"

    response = http.request registration_request
    resource.last_registration_response_code = response.code.to_i
    resource.last_registration_succeeded = resource.last_registration_response_code == 200
    resource.last_registration_response = response.body

    resource.save
    redirect_to resource_path
  end
  
  action_item :register_urls, only: :show do
    link_to 'Register the URLs', register_urls_admin_till_path(till)
  end
end
