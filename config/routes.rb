# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :api, default: { format: :json } do
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do
      resources :users, only: %i[index show create update destroy]
      resources :sessions, only: [:create]
      resources :recipients, only: %i[index show create update destroy]
      resources :deliverymans, only: %i[create index show update destroy] do
        resources :avatar, only: [:create]
      end
      resources :orders, only: %i[create index show update]
    end
  end
end
