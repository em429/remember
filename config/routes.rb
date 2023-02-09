Rails.application.routes.draw do
  root 'annotations#index'
  
  resources :users, param: :user_id

  resource :session, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :annotations do
    get 'filter/:filter' => 'annotations#index',
        on: :collection,
        as: 'filtered'
  end
  
  resources :books do
    get 'show_plaintext'
  end
  
  get 'import', to: 'annotations#import'
  post 'import', to: 'annotations#import'
end
