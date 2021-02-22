Rails.application.routes.draw do
  
  root to: "items#index"
  
  devise_scope :user do 
    get 'sign_up', to: "registrations#new"
    get 'sign_in', to: "sessions#new"
  end
  
  devise_for :users, controllers: { registrations: 'registrations', 
                                    sessions:      'sessions'}
end
