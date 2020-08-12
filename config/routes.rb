Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :c2b_transactions, only: [:index, :create, :show]
  post '/c2b_transactions/validate', as: 'validate_c2b_transaction'
end
