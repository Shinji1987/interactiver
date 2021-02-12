FactoryBot.define do
  factory :post do
    text { Faker::Lorem.sentence }

    association :user
  end
end