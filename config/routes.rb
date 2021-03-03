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
  resources :order_items
  resources :items
end
