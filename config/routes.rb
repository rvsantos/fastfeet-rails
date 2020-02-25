# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiVersion.new(version: 1, default: true) do
      # TODO: adds routes
    end
  end
end
