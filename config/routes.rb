Rails.application.routes.draw do
  resources :treatments
  resources :salons

  get "up" => "rails/health#show", as: :rails_health_check

  root "dashboard#index"
end
