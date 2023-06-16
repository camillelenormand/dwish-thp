Rails.application.routes.draw do
  resources :orders
  devise_for :users

  resources :carts do
    resources :cart_items
  end

  resources :cart_items
  resources :items

  resources :categories
  resources :users, only: [:index, :show, :edit, :update]


  scope '/checkout' do
    post 'create', to: 'checkouts#create', as: 'checkout_create'
    get 'success', to: 'checkouts#success', as: 'checkout_success'
    get 'cancel', to: 'checkouts#cancel', as: 'checkout_cancel'
    get 'error', to: 'checkouts#error', as: 'checkout_error'
    get 'expired', to: 'checkouts#expired', as: 'checkout_expired'
  end

  root 'welcome#index'
end
