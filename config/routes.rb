# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :api, default: { format: :json } do
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do
      resources :users, only: %i[index show create update destroy]
    end
  end
end
