require 'test_helper'

class ProducesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @produce = produces(:PerennialOne)
  end

  test "should get index" do
    get produces_url
    assert_response :success
  end

  test "should create produce" do
    assert_difference('Produce.count') do
      post produces_url, params: { produce: { duration: @produce.duration, name: "Tester" } }
    end
    assert_response :success
  end
  
  test "should not create produce due to non-unique name" do
    assert_no_difference('Produce.count') do
      post produces_url, params: { produce: { duration: @produce.duration, name: @produce.name } }
    end
    assert_response 422
  end

  test "should show produce" do
    get produce_url(@produce)
    assert_response :success
  end

  test "should update produce" do
    patch produce_url(@produce), params: { produce: { duration: @produce.duration, name: "UniqueName", type: @produce.type } }
    assert_response :success
  end

  test "should destroy produce" do
    assert_difference('Produce.count', -1) do
      delete produce_url(@produce)
    end
  end
  
end
