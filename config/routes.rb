Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :item_serches, only: [:index]

  resources :items do
    member do
      get 'preview'
    end
    collection do
      get 'search'
    end
    resources :likes, only: [:create, :destroy]
    resources :messages, only: [:create]
  end
  
  resources :users, only: [:show]
  resources :users, only: [:show, :create, :update]
  resources :categorys, only: [:index, :show]
  resources :brands, only: [:index, :show]
  resources :shipping_addresses, only: [:new, :create, :edit, :update]
  resources :identity_informations, only: [:new, :create, :edit, :update]
  resources :orders, only: [:show, :create] do
   collection do
    get 'done'
   end
  end
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  
end
