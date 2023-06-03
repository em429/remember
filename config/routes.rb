Rails.application.routes.draw do
  root 'content_pages#about'

  ## Users & Sessions
  # except: index
  resources :users, only: [ :new, :create, :show, :edit, :update, :destroy ]
  resource :session, only: [ :new, :create, :destroy ]

  ## Books
  resources :books do
    # Add plaintext nested inside member to keep it's param as id, not book_id
    member do
      resource :plaintext, only: [ :show ],
        controller: 'book_plaintexts', as: 'book_plaintext'
    end
  end

  ## Annotations & Flashcards
  resources :annotations, only: [ :index, :show ]
  resources :annotation_stars, only: [ :index, :update ]
  resources :annotation_imports, only: [ :create ]

  resources :flashcards, only: [ :update, :index ] do
    get 'unscored', on: :collection, to: 'flashcards#index'
    get 'due', on: :collection, to: 'flashcards#index'
  end

  ## News
  # except: show
  resources :rss_feeds, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :news, only: [ :index ]

  # URL aliases, must map to an existing canonical URL.
  # This is strictly for aesthetics, use the canonical paths in code, always.
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'news', to: 'news#index'

  ## Content page routes. These are not resource based, each page's name coressponds to
  ## a controller action on ContentPagesController
  get '/about', to: 'content_pages#about'

end

