class UsersController < ApplicationController
  helper_method :cause_logos ##will delete when we get real org logos.
  before_action :get_user, :get_donations_by_causes, only: [:show, :edit]

  def show
    @badges = @user.badges
  end

  def edit 
    @user_fav_orgs = @user.user_favorite_organizations[0..3]
  end

  def get_user
    @user = User.includes(donations: :organization, user_favorite_organizations: :organization).find(params[:id])
  end

  def get_donations_by_causes
    @donations_by_causes = @user.donations_by_causes
  end

  def cause_logos
    {
      "animals"        => "paw",
      "community"      => "users",
      "education"      => "graduation-cap",
      "environment"    => "tree",
      "health"         => "medkit",
      "human_rights"   => "street-view",
      "human_services" => "child",
      "international"  => "globe",
      "religion"       => "chrome"
    }
  end

end
