Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get 'public', to: 'public#public'
  get 'private', to: 'private#private'
  get 'private_to_service_1', to: 'private#private_to_service_1'
  get 'private_to_service_2', to: 'private#private_to_service_2'
  get 'private_to_service_1_with_service_2', to: 'private#private_to_service_1_with_service_2'
end
