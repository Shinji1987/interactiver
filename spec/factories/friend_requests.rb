FactoryBot.define do
  factory :friend_request do
    from_user_id               { 1 }
    to_user_id                 { 2 }
    requesting_status          { 1 }
  end
end