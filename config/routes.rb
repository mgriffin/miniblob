Rails.application.routes.draw do
  root "miniblobs#index"

  resources :miniblobs, only: :index
end
