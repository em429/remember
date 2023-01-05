Rails.application.routes.draw do
  get 'spaced_repetition', to: 'annotations#show_random'
  root 'annotations#show_random'
  
  resources :annotations
  resources :books do
    post 'text_extractions/start', as: 'start_text_extraction'
    get 'full_text'
  end
  get 'import', to: 'imports#index'
  post 'import', to: 'imports#create'
end
