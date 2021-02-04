FactoryBot.define do
  factory :chat_user do
    created_user_id { 1 }
    invited_user_id { 2 }

    association :chat
  end
end
