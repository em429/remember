Rails.application.routes.draw do
  root 'annotations#index'


  resources :users, except: [ :index ]


  resource :session, only: [ :new, :create, :destroy ]


  resources :books do
    # Add plaintext nested inside member to keep it's param as id, not book_id
    member do
      resource :plaintext, only: [ :show ],
        controller: 'book_plaintexts', as: 'book_plaintext'
    end
  end


  resources :annotations, only: [ :index, :show ] do
    get 'mode/:mode' => 'annotations#index',
        on: :collection,
        as: 'mode'
    post 'import', on: :collection, to: 'annotations#import'
  end

  resources :annotation_repetitions, only: [ :update ]

  # URL aliases, must map to an existing canonical URL.
  # This is strictly for aesthetics, use the canonical paths in code, always.
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
