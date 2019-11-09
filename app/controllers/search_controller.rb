# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    search_results = PgSearch.multisearch(params[:query]).includes(:searchable)

    @users = search_results.where(searchable_type: "User").limit(4)
    @organizations = search_results.where(searchable_type: "Organization").limit(6)
    @query = params[:query]
  end

  def organizations
    @organizations = Organization.search_by_name_type_location(params[:query])
  end

  def users
    @users = User.search_by_name_email_location(params[:query])
  end
end
