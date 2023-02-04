Rails.application.routes.draw do
  root 'annotations#index'
  
  resources :annotations do
    get 'filter/:filter' => 'annotations#index',
        on: :collection,
        as: 'filtered'
  end
  
  resources :books do
    get 'show_plain_text'
    post 'extract_plain_text'
  end
  
  get 'import', to: 'annotations#import'
  post 'import', to: 'annotations#import'
end
