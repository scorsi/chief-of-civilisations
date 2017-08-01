Rails.application.routes.draw do

  get 'buildings', to: 'buildings#index', as: 'buildings_index'

  get 'buildings/:name', to: 'buildings#show', as: 'buildings_show'

  devise_for :users

  root 'home#index'

  default_url_options host: 'localhost:3000'
end
