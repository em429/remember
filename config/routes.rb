Rails.application.routes.draw do
  root 'annotations#index'

  ### Users & Signup
  resources :users, param: :user_id
  get 'signup', to: 'users#new'
  ###

  ### Sessions
  resource :session, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  ###
  

  ### Annotations
  resources :annotations do
    get 'filter/:filter' => 'annotations#index',
        on: :collection,
        as: 'filtered'
  end
  get 'import', to: 'annotations#import'
  post 'import', to: 'annotations#import'
  ###

  ### Books
  resources :books do
    get 'show_plaintext'
  end
  ###

end
