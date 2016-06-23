require 'test_helper'

class RegistrationsControllerTest < ActionController::TestCase
  test "should get devise" do
    get :devise
    assert_response :success
  end

end
