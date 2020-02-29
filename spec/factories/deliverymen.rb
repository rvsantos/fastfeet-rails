FactoryBot.define do
  factory :deliveryman do
    name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :with_avatar do
      avatar { fixture_file_upload('spec/fixtures/avatar.png') }
    end
  end
end
