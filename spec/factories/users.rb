FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.unique.last_name }
    location {Faker::Address.state}
    nick_name {Faker::Superhero.name}
    email { Faker::Internet.email("#{first_name} #{last_name}", ".") }
    password { Faker::Internet.password }

    factory :user_with_favorite_organizations, aliases: [:user_with_fav_orgs] do
      transient do
        num_fav_orgs { 1 }
      end
      after(:create) do |user, evaluator|
        create_list(:user_fav_org, evaluator.num_fav_orgs, user: user)
      end
    end
  end
end

