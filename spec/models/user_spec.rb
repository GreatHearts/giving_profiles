require "rails_helper"

RSpec.describe User, type: :model do
  subject { User.new(name: "Foo Bar") }

  it { should validate_presence_of(:fb_id) }
  it { should validate_uniqueness_of(:fb_id) }
  it { should validate_uniqueness_of(:email) }
end
