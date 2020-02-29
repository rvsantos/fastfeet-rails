FactoryBot.define do
  factory :order do
    recipient
    deliveryman
    product { Faker::Commerce.product_name }
    canceled_at { nil }
    start_date { nil }
    end_date { nil }
  end
end
