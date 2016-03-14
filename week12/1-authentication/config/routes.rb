Rails.application.routes.draw do
  get 'signup' => 'users#new'
  post 'users' => 'users#create'
  resources :users

  get 'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'sessions#home'
end
