Rails.application.routes.draw do
  namespace :admin do
    #  resources :orders     (will be used later)
      resources :items
      resources :categories
    #  resources :cart_items (will be used later)
    #  resources :carts      (will be used later)
    #  resources :users      (will be used later)

      root to: "items#index"
    end
  devise_for :users

  resources :cart_items
  resources :carts
  resources :items
  resources :categories
  resources :users, only: [:index, :show, :edit, :update]

  # webhooks
  post '/webhooks', to: 'webhooks#create'


  scope '/checkouts' do
    post 'create', to: 'checkouts#create', as: 'checkouts_create'
    get 'success', to: 'checkouts#success', as: 'checkouts_success'
    get 'cancel', to: 'checkouts#cancel', as: 'checkouts_cancel'
    get 'error', to: 'checkouts#error', as: 'checkouts_error'
  end

  root 'welcome#index'
end
