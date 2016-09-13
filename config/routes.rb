Rails.application.routes.draw do
  resources :cards
  resources :games, except: [:new] do
    resources :rounds
  end
  resources :users
  # resources :players

  post '/players/nickname', to: 'players#show'
  post '/games/:id/play', to: 'rounds#play'

  post '/games/join', to: 'games#join', as: 'game_join'
  get '/dashboard', to: 'games#new', as: 'new_game'
  get '/games/:id/play', to: 'games#play', as: 'game_play'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/' => 'sessions#new', as: 'root'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'

  post '/actions/seer', to: 'games#seer'
  post '/actions/robber', to: 'games#robber'
  post '/actions/troublemaker', to: 'games#troublemaker'
  post '/vote', to: 'games#vote'

  resources :messages

  post '/get_player', to: 'rounds#get_player'
  mount ActionCable.server => '/cable'
end
