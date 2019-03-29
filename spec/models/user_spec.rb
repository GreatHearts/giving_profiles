require "rails_helper"

RSpec.describe User, type: :model do
  subject { users(:bob_user) }

  it { should define_enum_for(:favorite_cause).backed_by_column_of_type(:string) }

  it { should have_many(:user_favorite_organizations).dependent(:destroy) }
  it { should have_many(:donations).dependent(:destroy) }
  it do
    should have_many(:favorite_organizations)
      .through(:user_favorite_organizations)
      .source(:organization)
  end

  it { should validate_presence_of(:fb_id) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_uniqueness_of(:fb_id) }
  it { should validate_uniqueness_of(:email) }

  describe "#name" do 
    it "returns first_name plus last name with space in between." do 
      user = users(:bob_user)
      expect(user.name).to eql "Bob Bobson"
    end
  end
end
