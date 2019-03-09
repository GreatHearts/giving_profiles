def create_user(name)
  User.create_with(
    name: name,
    nick_name: Faker::Internet.username(name, ""),
    email: Faker::Internet.email(name),
    favorite_cause: User::favorite_causes.keys.sample,
    favorite_cause_description: Faker::Lorem.sentence(rand(4..10)),
    philosophy: [Faker::Quote.matz, Faker::Quote.yoda, Faker::Lorem.paragraph].sample,
    address: Faker::Address.full_address,
    yearly_income: rand(30..3000) * 1000,
    pic_url: Faker::Internet.url
  ).find_or_create_by!(fb_id: "#{Faker::Number.number(10)}")
end

def create_donation(user, organization)
  Donation.create!(
    user: user,
    organization: organization,
    amount: rand(1..5000) * 10
  )
end

def create_fav_org(user, organization)
  UserFavoriteOrganization.create_with(description: Faker::Lorem.sentence(rand(4..10)))
    .find_or_create_by!(user: user, organization: organization)
end

def random_user
  User.order("RANDOM()").first
end

def random_organization
  Organization.order("RANDOM()").first
end


ActiveRecord::Base.transaction do 
  
  ##Organizations
  orgs = YAML::load_file(Rails.root.join("db/seed_files/orgs.yml"))

  ## NOTE: Org type is being randomly assigned for now until we get a specific mapping. 
  orgs.each{ |org| Organization.find_or_create_by!(name: org[:name], fb_url: org[:fb_url], org_type: Organization::org_types.keys.sample) }

  if Rails.env == "development"
    ##Users. 
    num_users = 50 
    num_users.times do 
      begin
        create_user(Faker::Name.name)
      rescue
        retry if e.message.match /Email has already been taken/
      end
    end

    ##Donations. 
    num_donations = 500
    num_donations.times{ create_donation(random_user, random_organization) }

    ##Favorite Organizations. 
    num_fav_orgs = 50
    num_fav_orgs.times{ create_fav_org(random_user, random_organization) }
  end
end

puts "#{Organization.count} organizations in database."
puts "#{User.count} users in database."
puts "#{Donation.count} donations in database."
puts "#{UserFavoriteOrganization.count} user favorite organizations in database."