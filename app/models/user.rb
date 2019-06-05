# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  enum favorite_cause: Organization.org_types

  has_many :user_favorite_organizations, dependent: :destroy
  has_many :favorite_organizations, through: :user_favorite_organizations, source: :organization
  has_many :donations, dependent: :destroy

  validates :email, uniqueness: true

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.nick_name = auth.info.name
      user.avatar_url = auth.info.image # assuming the user model has a name
# assuming the user model has a name
    end
  end

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

  def profile_image
    avatar_url.present? ? avatar_url : "home-profile_01.jpg"
  end

  # rubocop:enable Metrics/AbcSize
end
