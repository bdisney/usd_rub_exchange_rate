Rails.application.routes.draw do
  root to: 'home#index', as: :home

  resources :exchange_rates
  get 'admin', to: 'exchange_rates#new'
end
