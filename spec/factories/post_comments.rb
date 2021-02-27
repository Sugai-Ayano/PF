FactoryBot.define do
  factory :post do
    content { Faker::Lorem.charactors(number: 20) }
    user
    post
  end
end