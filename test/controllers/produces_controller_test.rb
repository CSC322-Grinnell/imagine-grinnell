require 'test_helper'

class ProducesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @produce = produces(:one)
  end

  test "should get index" do
    get produces_url
    assert_response :success
  end

  test "should get new" do
    get new_produce_url
    assert_response :success
  end

  test "should create produce" do
    assert_difference('Produce.count') do
      post produces_url, params: { produce: { name: 'carrot', prediction_date: 'March', readiness: 1 } }
    end

    assert_redirected_to produce_url(Produce.last)
  end
  
  
  test "should not create duplicate" do
    assert_difference('Produce.count') do
      post produces_url, params: { produce: { name: 'carrot', prediction_date: 'March', readiness: 1 } }
    end
    assert_no_difference('Produce.count') do
      post produces_url, params: { produce: { name: 'carrot', prediction_date: 'March', readiness: 1 } }
    end
  end
  
  test "should show produce" do
    get produce_url(@produce)
    assert_response :success
  end

  test "should get edit" do
    get edit_produce_url(@produce)
    assert_response :success
  end

  test "should update produce" do
    patch produce_url(@produce), params: { produce: { name: 'test', prediction_date: @produce.prediction_date, readiness: @produce.readiness } }
    assert_redirected_to produce_url(@produce)
  end

  test "should destroy produce" do
    assert_difference('Produce.count', -1) do
      delete produce_url(@produce)
    end

    assert_redirected_to produces_url
  end
end
