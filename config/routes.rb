Rails.application.routes.draw do
  resources :students

  get "up" => "rails/health#show", as: :rails_health_check
end
