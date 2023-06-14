Rails.application.routes.draw do
  resources :cart_items
  resources :carts
  resources :items
  resources :categories

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  root 'welcome#index'
end
