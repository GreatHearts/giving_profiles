class User < ApplicationRecord
  enum favorite_cause: Organization::org_types

  has_many :user_favorite_organizations, dependent: :destroy
  has_many :favorite_organizations, through: :user_favorite_organizations, source: :organization
  has_many :donations, dependent: :destroy

  validates :fb_id, uniqueness: true, presence: true #this can be removed when some other signup/login method is added.
  validates :email, uniqueness: true
end
