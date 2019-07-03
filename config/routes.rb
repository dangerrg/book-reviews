Rails.application.routes.draw do
 get 'home/index'

  get 'users/new'

  get '/reviews/new'

  post '/reviews/create'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
