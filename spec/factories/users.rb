require 'date'

FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    from = Date.parse('1950/01/01')
    to   = Date.parse('2000/12/31')

    nickname              { 'ジョン' }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(:min_length => 6) }
    password_confirmation { password }
    family_name_kanji     { '滝本' }
    first_name_kanji      { '圭一' }
    family_name_kana      { 'タキモト' }
    first_name_kana       { 'ケイイチ' }
    birthday              { '1988-02-06' }
    profile               { '宜しくお願いします' }
  end
end