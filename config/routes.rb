Rails.application.routes.draw do
  root 'homes#index'
  get '/filter', to: 'homes#filtered_listings'
end
