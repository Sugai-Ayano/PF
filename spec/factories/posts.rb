FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 5) }
    caption { Faker::Lorem.characters(number: 20) }
    user {:user}
    image {
      File.open("#{Rails.root}/public/uploads/7658a25173474f006ae789c8cd58a19616acf09ed8f0ac853907baf1c452")
      }
    genre_id {"春"}
  end
end