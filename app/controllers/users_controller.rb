class UsersController < ApplicationController
  helper_method :cause_logos ##will delete when we get real org logos.

  def show
    @user = User.includes(donations: :organization, user_favorite_organizations: :organization).find(params[:id])
    @badges = @user.badges
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
