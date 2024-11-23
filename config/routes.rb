Rails.application.routes.draw do
  devise_for :users

  root "campaigns#index"

  resources :campaigns do
    resources :characters, except: [ :show ]
    resources :sessions, except: [ :index, :show ]
  end
  resources :campaign_memberships, only: [ :new, :create, :destroy ]

  get "up" => "rails/health#show", as: :rails_health_check
end
