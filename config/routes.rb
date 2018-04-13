require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root to: 'home#index', as: :home

  resources :exchange_rates
  get 'admin', to: 'exchange_rates#new'
end
