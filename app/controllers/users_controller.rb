class UsersController < ApplicationController
  def show
    @user = User.includes(donations: :organization, user_favorite_organizations: :organization).find(params[:id])
    @badges = @user.badges
    @donations_by_causes = @user.donations_by_causes
  end
end
