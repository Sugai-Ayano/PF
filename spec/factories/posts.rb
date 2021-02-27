FactoryBot.define do
  factory :post do
    title { Faker::Lorem.charactors(number: 5) }
    caption { FactoryBot::Lorem.charactors(number: 20) }
    user
    image
    genre
  end
end