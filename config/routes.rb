Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'sessions#new'
  get 'sessions/new'

  get  '/signup',  to: 'users#new'
  get '/checklogged', to: 'users#checklogged'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/getsubgenres', to: 'subgenres#getsubgenres'
  get '/newquiz', to: 'states#new'
  get '/quiz', to: 'states#quiz'
  get '/checkans', to: 'states#checkans'
  get '/getongoingquizzes', to: 'subgenres#ongoing'
  get '/continuequiz', to: 'states#contquiz'
  get '/leaderboard', to: 'states#leaderboard'
  get '/myquizzes', to: 'states#myquizzes'
  get '/fifty', to: 'states#fifty'
  get '/choose', to: 'states#choose'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
