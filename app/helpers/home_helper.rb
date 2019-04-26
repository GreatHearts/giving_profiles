module HomeHelper
  def login_page?
    controller_name == 'home' && action_name == 'login'
  end
end
