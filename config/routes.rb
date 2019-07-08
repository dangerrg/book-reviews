Rails.application.routes.draw do
  root to: 'home#index'

  get 'home/index'

  get 'users/new'

  get '/reviews/index'

  get '/reviews/new'

  post '/reviews/create'

  get '/reviews/:id/show', to: 'reviews#show', as: 'show_review'

  get '/reviews/:id/edit', to: 'reviews#edit', as: 'edit_review'

  patch '/reviews/:id', to: 'reviews#update', as: 'review'

  get 'account/reviews'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
