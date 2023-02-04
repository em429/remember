Rails.application.routes.draw do
  root 'annotations#index'
  
  resources :annotations do
    get 'filter/:filter' => 'annotations#index',
    on: :collection, as: 'filtered'
  end
  
  # get '/filter/:filter' => 'annotations#index', as: 'filtered_annotations'
 
  
  resources :books do
    post 'text_extractions/start', as: 'start_text_extraction'
    get 'full_text'
  end
  
  get 'import', to: 'annotations#import'
  post 'import', to: 'annotations#import'
end
