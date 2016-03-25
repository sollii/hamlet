Rails.application.routes.draw do
  root 'homes#index'
  get '/filter', to: 'homes#filtered_listings'
  get '/users/:id/listings', to: 'user#get_listings'
  get '/fuck', to: 'agent#index'
  patch '/users/:id/update', to: 'user#update'
  post '/filter/set', to: 'filters#set_filter'
end
