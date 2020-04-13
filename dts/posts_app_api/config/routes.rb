Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, constraints: { format: 'json' } do
    namespace :v1 do
      resources :posts, only: :index do
        post :toggle_like, on: :member

        resources :comments, only: :index
      end

      resources :sessions, only: :create
    end
  end

  root to: 'api/v1/posts#index', defaults: { format: :json }
end
