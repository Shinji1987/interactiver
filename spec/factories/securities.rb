FactoryBot.define do
  factory :security do
    block_user_id { 1 }
    blocked_user_id { 2 }
  end
end