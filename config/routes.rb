Rails.application.routes.draw do
  
  root to: "items#index"

  devise_scope :user do 
    get 'sign_up', to: "registrations#new"
    post 'sign_up', to: "registrations#create"
    get 'sign_in', to: "sessions#new"
    delete 'log_out', to: "sessions#destroy"
  end
  
  devise_for :users, controllers: { registrations: 'registrations', 
                                    sessions:      'sessions'}

  resources :orders, only: [:create, :show, :edit, :index]                                    
  resources :orders do 
    member do 
      patch :change_status
    end
  end

  resources :order_items 
  resources :items
  resources :categories
  resources :categorizations, only: [:create, :destroy]

  get "dashboard",            to: "dashboard#index"
  get 'dashboard/orders/:id', to: "dashboard#show", as: :dashboard_orders
  get 'dashboard/items',      to: "dashboard#items", as: :dashboard_items

  resources :sales
  resources :reviews, only: [:new, :create, :update, :delete]
end
