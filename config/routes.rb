Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :contents, only: [ :index ]

      resources :users, only: [] do
        get "favorite_channel_programs", to: "favorite_channel_programs#index"
        resources :favorite_apps, only: [ :index, :create ]
      end

      resources :movies, only: [ :show ]
      resources :tv_shows, only: [ :show ]
      resources :seasons, only: [ :show ]
      resources :episodes, only: [ :show ]
      resources :channels, only: [ :show ]
      resources :channel_programs, only: [ :show ]
    end
  end
end
