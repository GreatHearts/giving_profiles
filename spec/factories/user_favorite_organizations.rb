FactoryBot.define do
  factory :user_favorite_organization, aliases: [:user_fav_org] do
    user
    organization
    description { Faker::Lorem.sentence(word_count: rand(4..10)) }
    rank { 1 }
  end
end
