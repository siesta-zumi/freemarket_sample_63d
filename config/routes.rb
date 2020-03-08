Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, only: [:index, :new,:show,:create]
  resources :users, only: [:show]
  resources :identity_informations, only: [:new, :create]
  resources :shipping_addresses, only: [:new, :create]
  resources :orders, only: [:index, :show, :new, :create]
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
end
