class UsersController < ApplicationController
  def show
    @user = User.includes(donations: :organization, user_favorite_organizations: :organization).find(params[:id])
    @badges = @user.badges
  end
end
