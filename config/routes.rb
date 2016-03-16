Rails.application.routes.draw do
  root 'homes#index'
  get '/filter', to: 'homes#filtered_listings'
  get '/users/:id/listings', to: 'user#get_listings'
end
