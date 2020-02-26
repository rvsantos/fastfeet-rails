FactoryBot.define do
  factory :recipient do
    name { Faker::Name.name }
    street { Faker::Address.street_address }
    complement { Faker::Address.secondary_address }
    state { Faker::Address.state }
    city { Faker::Address.city }
    zip_code { Faker::Address.zip_code }
  end
end
