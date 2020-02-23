Rails.application.routes.draw do

  devise_for :users
  root "items#index"
  resources :items, only: [:index, :new,:show]
  resources :users, only: :show

  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
end
