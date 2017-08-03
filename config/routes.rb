Rails.application.routes.draw do

  root 'home#index'

  get 'buildings', to: 'building#index', as: 'building'

  get 'building/:name', to: 'building#show', as: 'building_show'

  post 'building/:name/upgrade', to: 'building#upgrade', as: 'building_upgrade'

  post 'building/:name/collect', to: 'building#collect', as: 'building_collect'

  post 'chief', to: 'chief#create', as: 'create_chief'

  delete 'chief', to: 'chief#delete', as: 'delete_chief'

  devise_for :users

end
