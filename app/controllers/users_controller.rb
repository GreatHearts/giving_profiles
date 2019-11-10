# frozen_string_literal: true

class UsersController < ApplicationController
  helper_method :cause_logos # #will delete when we get real org logos.
  before_action :user, :donations_by_causes, only: %i[home show edit add_donation]
  before_action :ensure_current_user, :verify_access, only: %i[home edit]

  def show
    @badges = @user.badges
  end

  def edit
    @user_fav_orgs = @user.user_favorite_organizations[0..3]
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Successfully saved profile changes!"
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages.join(";  ")
      render "edit"
    end
  end

  def home
    redirect_to login_path unless user_signed_in?
    @network_donations = Donation.order(created_at: :desc).first(5)
  end

  # /users/:id/add_donation
  def add_donation
    organization = Organization.find_or_create_by(name: user_params[:organization_name])
    @donation = DonationService.create_donation(@user, organization, user_params[:amount])
    if @donation.save
      flash[:success] = "Successfully added donation!"
      # should redirect to user home page
    else
      flash[:error] = @donation.errors.full_messages.join(";  ")
      # should redirect to user home page with errors
    end
    redirect_to :home_user
  end

  private

  def user
    @user = User.includes(donations: :organization, user_favorite_organizations: :organization).find(params[:id])
  end

  def donations_by_causes
    @donations_by_causes = @user.donations_by_causes
  end

  def cause_logos
    {
      "animals" => "paw",
      "community" => "users",
      "education" => "graduation-cap",
      "environment" => "tree",
      "health" => "medkit",
      "human_rights" => "street-view",
      "human_services" => "child",
      "international" => "globe",
      "religion" => "chrome"
    }
  end

  def user_params
    params.require(:user).permit(:first_name,
                                 :last_name,
                                 :location,
                                 :email,
                                 :philosophy,
                                 :favorite_cause_description,
                                 :organization_name,
                                 :amount,
                                 user_favorite_organizations_attributes: %i[id description])
  end

  def ensure_current_user
    redirect_to root_path unless user_signed_in?
  end

  def verify_access
    render_forbidden unless user_signed_in? && @user == current_user
  end

  def render_forbidden
    # TODO: Add 403 page and render it
    # render file: 'public/403.html', status: 403
    redirect_to root_path
  end
end
