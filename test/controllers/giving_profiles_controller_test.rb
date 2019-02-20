require 'test_helper'

class GivingProfilesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get giving_profiles_index_url
    assert_response :success
  end

end
