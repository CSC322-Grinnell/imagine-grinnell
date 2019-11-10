require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  # No idea why this fails, but it should be a test in the end product
  # Something to do with CSS
  test 'should get home' do
    get root_url
    assert_response :success
  end
end
