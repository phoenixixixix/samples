Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :movies, only: %i[show update]

  resources :genres, param: :slug, only: [] do
    resources :movies, only: %i[index]
  end

  ActiveAdmin.routes(self)

  root 'movies#index'
end
