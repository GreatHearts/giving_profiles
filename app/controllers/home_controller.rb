# frozen_string_literal: true

class HomeController < ApplicationController
  def login
    redirect_to home_user_path(current_user) if user_signed_in?
  end

  def about; end

  def policy; end

  def contact; end
end
