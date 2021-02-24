Rails.application.routes.draw do
  
  root to: "items#index"

  devise_scope :user do 
    get 'sign_up', to: "registrations#new"
    get 'sign_in', to: "sessions#new"
    delete 'log_out', to: "sessions#destroy"
  end
  
  devise_for :users, controllers: { registrations: 'registrations', 
                                    sessions:      'sessions'}

  resources :orders, only: [:create, :show, :edit]                                    
  resources :order_items
end
