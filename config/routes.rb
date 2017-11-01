  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
require 'api_constraints'
Rails.application.routes.draw do

  apipie
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do  

      resources :user_sessions, only: [:new, :create, :destroy]
      get '/sign_in', to: 'user_sessions#new', as: :sign_in
      delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out

      resources :users do
        resources :transfers
      end
    end
  end
end
