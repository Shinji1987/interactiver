FactoryBot.define do
  factory :read do
    received_user_id { 1 }
    complete { 0 }

    association :message
  end
end
