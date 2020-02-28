FactoryBot.define do
  factory :deliveryman do
    name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :with_avatar do
      avatar do
        fixture_file_upload(
          Rails.root.join('spec/support/assets/avatar.png'), 'image/png'
        )
      end
    end
  end
end
