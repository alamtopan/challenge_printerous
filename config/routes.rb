Rails.application.routes.draw do

  root 'public#home'
  devise_for :users

  namespace :panel_control do
    get 'dashboard', to: 'home#dashboard', as: 'dashboard'
    resources :admins
    resources :account_managers
    resources :organizations
    resources :person_members
  end
end
