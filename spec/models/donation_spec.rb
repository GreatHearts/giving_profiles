require "rails_helper"

RSpec.describe Donation, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:organization) }

#   should be positive amount
  it "should have a positive amount" do
    organization = create :organization
    user = create :user
    donation = Donation.new(user: user, organization: organization, amount: 1)

    expect(donation).to be_valid

    donation.update_attribute(:amount, -1)

    expect(donation).not_to be_valid
  end

  it "should have an amount" do
    organization = create :organization
    user = create :user
    donation = Donation.new(user: user, organization: organization)

    expect(donation).not_to be_valid
  end

  describe "#all_newest_first" do
    it "should return donations in descending order" do
      organization = create :organization
      user = create :user
      first_donation = Donation.create(user: user, organization: organization, amount: 2, created_at: 5.days.ago)
      Donation.create(user: user, organization: organization, amount: 5, created_at: 2.days.ago)

      all_donations = Donation.all_newest_first
      expect(all_donations.first.id).to equal(first_donation.id)
    end
  end
#
#   DonationController
#     - test that @new_donation is available and not null( has user)
#     - sets user before creating/editing/deleting
#     - returns to User Home page after create
end
