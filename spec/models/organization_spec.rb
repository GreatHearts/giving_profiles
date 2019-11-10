require "rails_helper"

RSpec.describe Organization, type: :model do
  it {should have_many(:donations).dependent(:destroy)}

  describe "Searching" do
    before do
      @organization =
          Organization.create(
              name: Faker::Company::name,
              org_type: Organization.org_types.first.first,
              location: "#{Faker::Address.city}, IL"
          )
    end

    it "return results if there are matches " do
      name_result = PgSearch.multisearch(@organization.name)
      org_type_result = PgSearch.multisearch(@organization.org_type)
      location_result = PgSearch.multisearch(@organization.location)

      expect(name_result.present?).to be true
      expect(name_result.map(&:searchable).include?(@organization)).to be true
      expect(name_result.first.searchable.name).to eq @organization.name
      allow(@organization).to receive(:org_type).and_return("animals")

      search_result_org_type = org_type_result.first.searchable.org_type
      expect(search_result_org_type).to eq @organization.org_type
      expect(location_result.first.searchable.location).to eq @organization.location
      expect(location_result.first.searchable.id).to eq @organization.id
      expect(name_result.present?).to be true
      expect(name_result.map(&:searchable).include?(@organization)).to be true

      expect(org_type_result.present?).to be true
      expect(org_type_result.map(&:searchable).include?(@organization)).to be true

      expect(location_result.present?).to be true
      expect(location_result.map(&:searchable).include?(@organization)).to be true
    end

    it "does NOT return results if there are no matches" do
      result = PgSearch.multisearch("Not There")

      expect(result.empty?).to be true
    end
  end
end
