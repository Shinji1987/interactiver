FactoryBot.define do
  factory :shop do
    shop_name           { 'Paradise Shisha Bar' }
    shop_category_id    { 2 }
    shop_description   { 'シーシャがメインのバーです' }
    shop_address        { 'ミャンマー　ヤンゴン' }

    association :user
  end
end
