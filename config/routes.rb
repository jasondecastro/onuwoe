Rails.application.routes.draw do
  resources :cards
  resources :games, except: [:new]
  resources :users
  # resources :players

  post '/players/nickname', to: 'players#show'

  post '/games/join', to: 'games#join', as: 'game_join'
  get '/dashboard', to: 'games#new', as: 'new_game'
  get '/games/:id/play', to: 'games#play', as: 'game_play'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/' => 'sessions#new', as: 'root'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
end
