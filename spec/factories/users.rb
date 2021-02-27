FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 10) }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.characters(number: 20) }
    postal_code { Faker::Lorem.characters(number: 7) }
    prifecture_code { Faker::Lorem.characters(number: 3) }
    city { Faker::Lorem.characters(number: 3) }
    password { 'password'}
    password_confirmation { 'password'}
  end
end