Rails.application.routes.draw do
  root 'annotations#index'

  ### Users & Signup
  resources :users, param: :user_id, except: [:index]
  get 'signup', to: 'users#new'
  ###

  ### Sessions
  resource :session, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  ###
  

  ### Annotations
  resources :annotations, only: [:index, :show] do
    get 'filter/:filter' => 'annotations#index',
        on: :collection,
        as: 'filtered'
    post 'import', on: :collection, to: 'annotations#import'
  end
  ###

  ### Books
  resources :books do
    get 'show_plaintext'
  end
  ###

end
