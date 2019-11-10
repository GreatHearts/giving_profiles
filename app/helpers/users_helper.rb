# frozen_string_literal: true

module UsersHelper
  def show_edit_button?(_user)
    if user_profile_page?
      "d-block"
    else
      "d-none"
    end
  end

  def show_location?
    if user_profile_page?
      "d-block"
    else
      "d-none"
    end
  end

  def user_profile_page?
    controller_name == "users" && action_name == "show"
  end

  def user_header_avatar_size
    user_profile_page? ? "user-header__image" : "user-header__image user-header__image--xs"
  end

  def user_header_info_alignment
    user_profile_page? ? "align-self-end" : "align-self-center"
  end
end
