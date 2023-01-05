Rails.application.routes.draw do
  resources :annotations
  resources :books do
    post 'text_extractions/start', as: 'start_text_extraction'
    get 'full_text'
  end
  get 'import', to: 'imports#index'
  post 'import', to: 'imports#create'

  root 'annotations#index'
end
