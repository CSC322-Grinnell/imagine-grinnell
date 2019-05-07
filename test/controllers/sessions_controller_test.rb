require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  
  test "should create session" do
    post login_path, params: { session: { email: "admin@admin.com", password: "password" } }
    assert_response :success
  end
  
  test "should destroy session" do
    delete logout_path
    assert_response :success
  end
  
end