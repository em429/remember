Rails.application.routes.draw do
  get 'imports/index'
  get 'imports/create'
  resources :annotations
  resources :books
  get 'import', to: 'imports#index'
  post 'import', to: 'imports#create'

  root 'annotations#index'
end
