require 'test_helper'

class ProducesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @Produce = produces(:one)
    @PerennialProduce = produces(:PerennialProduceOne)
    @AnnualProduce = produces(:AnnualProduceOne)
  end

  test 'should get index' do
    get produces_url
    assert_response :success
  end

  test 'should not create produce' do
    assert_no_difference('Produce.count') do
      post produces_url, params: { produce: { duration: @Produce.duration, name: @Produce.name } }
    end
    assert_response 422
  end

  test 'should create perennial produce' do
    assert_difference('PerennialProduce.count') do
      post produces_url, params: { produce: { duration: @PerennialProduce.duration, name: @PerennialProduce.name, type: @PerennialProduce.type } }
    end
    assert_response :success
  end

  test 'should create annual produce' do
    assert_difference('AnnualProduce.count') do
      post produces_url, params: { produce: { duration: @AnnualProduce.duration, name: @AnnualProduce.name, type: @AnnualProduce.type } }
    end
    assert_response :success
  end

  test 'should not create perennial produce due to non-unique name' do
    assert_no_difference('PerennialProduce.count') do
      post produces_url, params: { produce: { duration: @PerennialProduce.duration, name: @PerennialProduce.name, type: @PerennialProduce.type } }
    end
    assert_response 422
  end

  test 'should show perennial produce' do
    get produce_url(@PerennialProduce)
    assert_response :success
  end

  test 'should update perennial produce' do
    patch produce_url(@PerennialProduce), params: { produce: { duration: @PerennialProduce.duration, name: 'UniqueName', type: @PerennialProduce.type} }
    assert_response :success
  end

  test 'should destroy perennial produce' do
    assert_difference('Produce.count', -1) do
      delete produce_url(@PerennialProduce)
    end
  end
end
