Rails.application.routes.draw do
    root 'list_rank#home'
    post 'search', to: 'list_rank#search'
  end
