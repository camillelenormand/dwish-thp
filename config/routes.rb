Rails.application.routes.draw do
  resources :cart_items
  resources :carts
  resources :items

  # Nested routes
  resources :categories do
    resources :items
  end

  devise_for :users

  resources :users, only: [:index, :show, :edit, :update]

  root 'welcome#index'
end
