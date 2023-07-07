Rails.application.routes.draw do
  namespace :admin do
      resources :items
      resources :categories
      root to: "items#index"
    end
    
    devise_for :users, controllers: {
      :sessions => "users/sessions",
      :registrations => "users/registrations" }

  resources :cart_items
  resources :carts
  resources :items
  resources :categories
  resources :users, only: [:index, :show, :edit, :update]

  # webhooks
  post '/webhooks', to: 'webhooks#create'

  # checkouts
  scope '/checkouts' do
    post 'create', to: 'checkouts#create', as: 'checkouts_create'
    get 'success', to: 'checkouts#success', as: 'checkouts_success'
    get 'cancel', to: 'checkouts#cancel', as: 'checkouts_cancel'
    get 'error', to: 'checkouts#error', as: 'checkouts_error'
  end

  root 'welcome#index'
end
