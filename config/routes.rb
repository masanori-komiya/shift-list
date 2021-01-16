Rails.application.routes.draw do
  get 'toppages/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root 'toppages#index'
  
  resources :shifts
  put '/shifts/:designated_on', to: 'shifts#update'
  
  resources :users, :only => [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
