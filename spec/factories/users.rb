require 'date'

FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end

    from = Date.parse('1950/01/01')
    to   = Date.parse('2000/12/31')

    nickname              { person.last.kanji }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    family_name_kanji     { person.last.kanji }
    first_name_kanji      { person.first.kanji }
    family_name_kana      { person.last.katakana }
    first_name_kana       { person.first.katakana }
    birthday              { p Random.rand(from..to) }
    profile               { '宜しくお願いします' }
  end
end
