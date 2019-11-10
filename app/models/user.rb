# frozen_string_literal: true

class User < ApplicationRecord
  include PgSearch
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]
  enum favorite_cause: Organization.org_types
  multisearchable against: %i[first_name last_name nick_name location],
                  update_if: %i[
                    first_name_changed?
                    last_name_changed?
                    nick_name_changed?
                    location_changed?
                  ]

  has_many :user_favorite_organizations, dependent: :destroy
  has_many :favorite_organizations, through: :user_favorite_organizations, source: :organization
  has_many :donations, dependent: :destroy

  validates :email, uniqueness: true
  validates_presence_of :first_name, :last_name

  accepts_nested_attributes_for :user_favorite_organizations

  # rubocop:disable AbcSize
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0, 20]
      user.nick_name = auth.extra.raw_info.short_name
      user.avatar_url = auth.info.image + "?type=large" # assuming the user model has a name
      user.uid = auth.uid
      user.provider = auth.provider
    end
  end
  # rubocop:enable AbcSize

  def badges
    donated_causes.uniq
  end

  def name
    "#{first_name} #{last_name}"
  end

  def donated_causes
    @donated_causes ||= Organization.joins(donations: :user).where("user_id = ?", id).pluck(:org_type)
  end

  ## NOTE: not yet stable. still experimenting. Need additional details. disable linting for this stand-in logic
  # rubocop:disable Metrics/AbcSize
  def donations_by_causes
    return @donations_by_causes if @donations_by_causes.present?

    @donations_by_causes = donated_causes.group_by(&:itself)
                                         .transform_values { |v| (v.size.to_f * 100 / donated_causes.size).round }
                                         .sort_by { |d_by_c| -d_by_c[1] }

    if @donations_by_causes.size > 4
      @donations_by_causes = @donations_by_causes[0..2] << ["others",
                                                            @donations_by_causes[3..-1].map(&:second).reduce(:+)]
    end
    @donations_by_causes
  end

  # @todo Move to a helper
  def profile_image
    avatar_url.present? ? avatar_url : "default_avatar"
  end
  # rubocop:enable Metrics/AbcSize
end
