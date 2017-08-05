Rails.application.routes.draw do

  root 'home#index'

  get 'overview', to: 'home#overview', as: 'overview'

  get 'buildings', to: 'building#index', as: 'building'

  get 'building/:building_name', to: 'building#show', as: 'building_show'

  post 'building/:building_name/upgrade', to: 'building#upgrade', as: 'building_upgrade'

  post 'building/:building_name/collect/:resource_name', to: 'building#collect', as: 'building_collect'

  post 'chief', to: 'chief#create', as: 'create_chief'

  delete 'chief', to: 'chief#delete', as: 'delete_chief'

  devise_for :users

end
