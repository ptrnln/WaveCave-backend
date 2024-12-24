Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get "/", to: "static_pages#api_index"
  if Rails.env.development? 
    namespace :api, defaults: { format: :json } do
      defaults format: :json do
        get "users/@:username/tracks/:title" => "tracks#show", title: /[^\/]+/
        get "users/@:username" => "users#show", username: /[^\/]+/
        resources :users, only: [ :index, :create, :show  ]
        resource :session, only: [ :show, :create, :destroy ]
        resources :tracks
        resources :playlists
        resources :playlist_tracks, only: [ :create ]

      end
    end
    get '*path', to: redirect("/")
  else 
    defaults format: :json do
      get "users/@:username/tracks/:title" => "tracks#show", title: /[^\/]+/
      get "users/@:username" => "users#show", username: /[^\/]+/
      resources :users, only: [ :index, :create, :show  ]
      resource :session, only: [ :show, :create, :destroy ]
      resources :tracks
      resources :playlists

      
    end
    get '*path', to: redirect("/wavecave") 
  end
end
