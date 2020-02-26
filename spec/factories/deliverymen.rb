FactoryBot.define do
  factory :deliveryman do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
