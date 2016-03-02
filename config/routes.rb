Rails.application.routes.draw do
  root 'homes#index'
  post 'search', to: 'list_rank#search'
end
