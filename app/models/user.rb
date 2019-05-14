# frozen_string_literal: true
class User < ApplicationRecord
  enum favorite_cause: Organization.org_types
  include PgSearch
  multisearchable against: %i[nick_name email location],
                  update_if: [:nick_name_changed?, :email_changed?, location_changed?]

  has_many :user_favorite_organizations, dependent: :destroy
  has_many :favorite_organizations, through: :user_favorite_organizations, source: :organization
  has_many :donations, dependent: :destroy

  validates :fb_id, uniqueness: true, presence: true # this can be removed when some other signup/login method is added.
  validates :email, uniqueness: true
  validates_presence_of :first_name, :last_name

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
                               .transform_values {|v| (v.size.to_f * 100 / donated_causes.size).round}
                               .sort_by {|d_by_c| -d_by_c[1]}

    if @donations_by_causes.size > 4
      @donations_by_causes = @donations_by_causes[0..2] << ["others",
                                                            @donations_by_causes[3..-1].map(&:second).reduce(:+)]
    end
    @donations_by_causes
  end
  # rubocop:enable Metrics/AbcSize
end
