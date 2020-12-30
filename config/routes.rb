Rails.application.routes.draw do

  get "/uanet", to: "records#index"
  resources :records, path: '/uanet/records'
  get '/uanet/records', to: redirect('/uanet')

  get '/uanet/signup', to: 'users#new'
  resources :users, except: [:new], path: 'uanet/users'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
