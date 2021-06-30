require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?

  devise_for :users

  resources :top, only: %i[index]
  resources :clients do
    resources :activity_logs, only: %i[new create edit update destroy] do
      post :start, on: :collection
      patch :finish, on: :member

      resources :rest_logs, only: %i[edit update destroy] do
        post :start, on: :collection
        patch :finish, on: :member
      end
    end
  end

  root 'clients#index'
end
