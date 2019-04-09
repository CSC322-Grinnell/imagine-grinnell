require 'test_helper'

class GardenProducesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @garden_produce = garden_produces(:one)
  end

  test "should get index" do
    get garden_produces_url
    assert_response :success
  end

  test "should create garden_produce" do
    assert_difference('GardenProduce.count') do
      post garden_produces_url, params: { garden_produce: { available_at: @garden_produce.available_at, garden_id: @garden_produce.garden_id, produce_id: @garden_produce.produce_id, readiness: @garden_produce.readiness } }
    end
  end

  test "should show garden_produce" do
    get garden_produce_url(@garden_produce)
    assert_response :success
  end

  test "should get edit" do
    get edit_garden_produce_url(@garden_produce)
    assert_response :success
  end

  test "should update garden_produce" do
    patch garden_produce_url(@garden_produce), params: { garden_produce: { available_at: @garden_produce.available_at, garden_id: @garden_produce.garden_id, produce_id: @garden_produce.produce_id, readiness: @garden_produce.readiness } }
    assert_response :success
  end

  test "should destroy garden_produce" do
    assert_difference('GardenProduce.count', -1) do
      delete garden_produce_url(@garden_produce)
    end
  end
end
