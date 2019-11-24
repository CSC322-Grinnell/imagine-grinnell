require 'test_helper'

class ProducesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @Produce = Produce.new(name: "ProduceTest")
    @PerennialProduce1 = PerennialProduce.new(name: "PerennialTest", start_date: "2019/1/1", end_date: "2019/11/30")
    @PerennialProduce2 = PerennialProduce.new(name: "PerennialTest", start_date: "2019/1/1", end_date: "2019/11/1")
    @AnnualProduce = PerennialProduce.new(name: "AnnualTest", duration: "60")
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
      post perennial_produces_url, params: { produce: { name: @PerennialProduce1.name, start_date: @PerennialProduce1.start_date, end_date: @PerennialProduce1.end_date } }
    end
    assert_response :success
  end

  test 'should create annual produce' do
    assert_difference('AnnualProduce.count') do
      post annual_produces_url, params: { produce: { duration: @AnnualProduce.duration, name: @AnnualProduce.name} }
    end
    assert_response :success
  end

  test 'should not create perennial produce due to non-unique name' do
    post perennial_produces_url, params: { produce: { name: @PerennialProduce1.name, start_date: @PerennialProduce1.start_date, end_date: @PerennialProduce1.end_date } }
    assert_no_difference('PerennialProduce.count') do
      post perennial_produces_url, params: { produce: { name: @PerennialProduce1.name, start_date: "2019/2/2", end_date: "2019/12/31" } }
    end
    assert_response 422
  end
#
#  test 'should show perennial produce' do
#    get perennial_produce_url(@PerennialProduce)
#    assert_response :success
#  end
#
#  test 'should update perennial produce' do
#    patch perennial_produce_url(@PerennialProduce), params: { produce: { name: "UniqueName", start_date: @PerennialProduce.start_date, end_date: @PerennialProduce.end_date} }
#    assert_response :success
#  end
#
#  test 'should destroy perennial produce' do
#    assert_difference('Produce.count', -1) do
#      delete perennial_produce_url(@PerennialProduce)
#    end
#  end
end
