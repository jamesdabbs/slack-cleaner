Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :auth }

  resources :channels, only: [:index, :destroy]
  resources :groups,   only: [:destroy]

  root to: "channels#index"
end
