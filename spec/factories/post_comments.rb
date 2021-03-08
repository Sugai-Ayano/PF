FactoryBot.define do
  factory :post_comment do
    content { Faker::Lorem.charactors(number: 20) }
    user
    post
  end
end