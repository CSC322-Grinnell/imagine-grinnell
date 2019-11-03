require 'test_helper'

class GardensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @garden = gardens(:one)
  end

  test "should get index" do
    get gardens_url
    assert_response :success
  end

  test "should create garden" do
    assert_difference('Garden.count') do
      post gardens_url, params: { garden: { address: @garden.address, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1, 
                                            email_1: @garden.email_1, lat: @garden.lat, long: @garden.long, name: @garden.name } } 
    end
    assert_response :success
  end

  test "should show garden" do
    get garden_url(@garden)
    assert_response :success
  end

  test "should update garden" do
    patch garden_url(@garden), params: { garden: { address: @garden.address, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1, 
                                                   email_1: @garden.email_1, lat: @garden.lat, long: @garden.long, name: @garden.name } }
    assert_response :success
  end

  test "should destroy garden" do
    assert_difference('Garden.count', -1) do
      delete garden_url(@garden)
    end
  end
  
end
