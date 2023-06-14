Rails.application.routes.draw do
  devise_for :users

  resources :cart_items
  resources :carts
  resources :items
  resources :categories
  resources :users, only: [:index, :show, :edit, :update]

  scope '/checkout' do
    get 'create', to: 'checkouts#create', as: 'checkout_create'
    get 'success', to: 'checkouts#success', as: 'checkout_success'
    get 'cancel', to: 'checkouts#cancel', as: 'checkout_cancel'
  end

  root 'welcome#index'
end
