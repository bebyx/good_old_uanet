Rails.application.routes.draw do

  get "/uanet", to: "records#index"
  resources :records, path: '/uanet/records'
end
