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

  resources :flashcards, only: [ :update ]
  resources :unscored_flashcards, only: [ :index ]
  resources :due_flashcards, only: [ :index ]

  ## News
  resources :rss_feeds, only: [ :index, :new, :create, :edit, :update, :destroy ] # except :show
  resources :rss_feed_fetches, only: [ :create ]
  # The 'news' resource functions as a dashboard of various rss_feeds
  resources :news, only: [ :index ]

  # URL aliases, must map to an existing canonical URL.
  # This is strictly for aesthetics, use the canonical paths in code, always.
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'news', to: 'news#index'
  get 'flashcards', to: redirect('/due_flashcards')

  ## Content page routes. These are not resource based, each page's name coressponds to
  ## a controller action on ContentPagesController
  get '/about', to: 'content_pages#about'

end
