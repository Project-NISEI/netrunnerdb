Rails.application.routes.draw do
  devise_for :users
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#home'

  get '/help', to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  resources :users, only: [:show]
  resources :nr_cycles, param: :code
  resources :nr_sets, param: :code
  resources :nr_set_types
  resources :cards, param: :code, only: %i[index show]
  resources :legality_types

  resources :search, only: [:index]

  get '/card/:nr_set/:position/(/:code)', to: 'printings#show', as: 'printing'

  get '/card_images/:nr_set/:code', to: 'images#serve', as: 'image'
end
