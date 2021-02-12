FactoryBot.define do
  factory :message do
    content { "Hello" }
    sent_user_id { 1 }
    received_user_id { 2 }

    association :chat
  end
end