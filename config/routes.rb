Rails.application.routes.draw do
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
