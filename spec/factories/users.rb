# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 12_345_678 }
    password_confirmation { 12_345_678 }
  end
end
