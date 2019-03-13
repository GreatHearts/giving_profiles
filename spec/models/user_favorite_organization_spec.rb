require "rails_helper"

RSpec.describe UserFavoriteOrganization, type: :model do
  subject { described_class.new(user_id: user.id, organization_id: organization.id) }

  let(:user) { users(:bob_user) }
  let(:organization) { organizations(:bob_organization) }

  it { should belong_to(:user) }
  it { should belong_to(:organization) }

  it { should validate_uniqueness_of(:user_id).scoped_to(:organization_id) }
end
