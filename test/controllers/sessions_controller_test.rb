require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = User.create(email: "admin@admin.com", password: "password", password_confirmation: "password")
    user.save
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