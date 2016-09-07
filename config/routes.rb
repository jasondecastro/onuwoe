Rails.application.routes.draw do
  resources :cards
  resources :games, except: [:new]
  resources :users

  post '/games/join', to: 'games#join', as: 'game_join'
  get '/dashboard', to: 'games#new', as: 'new_game'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'

  get '/' => 'sessions#new', as: 'root'
  post '/signin' => 'sessions#create'
  get '/signout' => 'sessions#destroy'
end
