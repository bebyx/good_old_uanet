Rails.application.routes.draw do

  get "/uanet", to: "records#index"
  resources :records, path: '/uanet/records'
  get '/uanet/records', to: redirect('/uanet')
  match '/uanet/records/:id/approve', to: 'records#approve', as: 'records_approve', via: :patch

  get '/uanet/signup', to: 'users#new', as: 'new_user'
  resources :users, except: [:new], path: '/uanet/users'
  get '/uanet/admin', as: 'admin', to: 'users#admin'

  scope '/uanet' do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
  end
end
