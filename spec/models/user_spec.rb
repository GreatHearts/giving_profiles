require "rails_helper"

RSpec.describe User, type: :model do
  subject { users(:bob_user) }

  it { should define_enum_for(:favorite_cause).backed_by_column_of_type(:string) }

  it { should have_many(:user_favorite_organizations).dependent(:destroy) }
  it { should have_many(:donations).dependent(:destroy) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }

  it do
    should have_many(:favorite_organizations)
      .through(:user_favorite_organizations)
      .source(:organization)
  end

  it "should validate that email is case-sensitively unique" do
    user = users(:bob_user)
    new_user = User.new(first_name: "John", last_name: "Doe", email: user.email)
    expect(new_user.valid?).to be_falsey
    new_user.update_attribute(:email, user.email.upcase)
    expect(new_user.valid?).to be_falsey
  end

  describe "#name" do 
    it "returns first_name plus last name with space in between." do 
      user = users(:bob_user)
      expect(user.name).to eql "Bob Bobson"
    end
  end

  describe "Searching" do
    let(:user) {create :user, password: Devise.friendly_token[0, 20]}

    it "return results if there are matches " do
      first_name_result = PgSearch.multisearch(user.first_name)
      last_name_result = PgSearch.multisearch(user.last_name)
      full_name_result = PgSearch.multisearch(user.name)
      location_result = PgSearch.multisearch(user.location)

      expect(first_name_result.first.searchable.first_name).to eq user.first_name
      expect(last_name_result.first.searchable.last_name).to eq user.last_name
      expect(full_name_result.first.searchable.name).to eq user.name
      expect(location_result.first.searchable.location).to eq user.location
      expect(location_result.first.searchable.id).to eq user.id
    end

    it "does NOT return results if there are no matches" do
      result = PgSearch.multisearch("Robert Fitzgerald Diggs")

      expect(result.empty?).to be true
    end
  end

#   network_donations
#     - in descending order
#     - has all donations in db (not yet filtered by network)
  describe "#network_donations" do
    it 'should return all donations in descending order ' do
      organization = create :organization
      user = create :user
      first_donation = Donation.create(user: user, organization: organization, amount: 2, created_at: 5.days.ago)
      Donation.create(user: user, organization: organization, amount: 2, created_at: 2.days.ago)

      expect(user.network_donations.first).to eq(first_donation)
    end
  end

end
