Rails.application.routes.draw do
  root 'content_pages#intro'

  get 'intro', to: 'content_pages#intro'


  resources :users, except: [ :index ]


  resource :session, only: [ :new, :create, :destroy ]


  resources :books do
    # Add plaintext nested inside member to keep it's param as id, not book_id
    member do
      resource :plaintext, only: [ :show ],
        controller: 'book_plaintexts', as: 'book_plaintext'
    end
  end


  resources :annotation_stars, only: [ :index, :create, :update ]


  resources :annotations, only: [ :show ] do
    post 'import', on: :collection, to: 'annotations#import'
  end

  resources :flashcards, only: [ :index, :update ] do
    get 'unscored', on: :collection, to: 'flashcards#show_unscored'
    get 'due', on: :collection, to: 'flashcards#show_due'
  end

  resources :news_feed, only: [ :index ]

  # URL aliases, must map to an existing canonical URL.
  # This is strictly for aesthetics, use the canonical paths in code, always.
  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

end
