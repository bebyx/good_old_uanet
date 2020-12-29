Rails.application.routes.draw do

  get "/uanet", to: "records#index"
  resources :records, path: '/uanet/records'
  get '/uanet/records', to: redirect('/uanet')
end
