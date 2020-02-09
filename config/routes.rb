Rails.application.routes.draw do
  get 'items/index'
  resources :items, only: [:index]

end
