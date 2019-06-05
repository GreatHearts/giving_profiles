class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      set_flash_message(:notice, :warning, reason:'there was an issue saving your account', kind:'Facebook') if is_navigational_format?
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end
