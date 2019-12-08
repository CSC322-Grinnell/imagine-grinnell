require 'test_helper'

class ProducesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @produce = Produce.new(name: 'ProduceTest')
    @perennial_produce = PerennialProduce.new(id: '10', name: 'PerennialTest', start_date: '2019/1/1', end_date: '2019/11/30')
    @annual_produce = AnnualProduce.new(id: '11', name: 'AnnualTest', duration: '60')
  end

  test 'should get index' do
    get produces_url
    assert_response :success
  end

  test 'should not create produce' do
    assert_no_difference('Produce.count') do
      post produces_url, params: { produce: { duration: @produce.duration, name: @produce.name } }
    end
    assert_response 422
  end

  test 'should create perennial produce' do
    assert_difference('PerennialProduce.count') do
      post perennial_produces_url, params: { produce: { id: @perennial_produce.id, name: @perennial_produce.name, start_date: @perennial_produce.start_date, end_date: @perennial_produce.end_date } }
    end
    assert_response :success
  end

  test 'should not create perennial produce due to non-unique name' do
    post perennial_produces_url, params: { produce: { id: @perennial_produce.id, name: @perennial_produce.name, start_date: @perennial_produce.start_date, end_date: @perennial_produce.end_date } }
    assert_no_difference('PerennialProduce.count') do
      post perennial_produces_url, params: { produce: { id: @perennial_produce.id, name: @perennial_produce.name, start_date: '2019/2/2', end_date: '2019/12/31' } }
    end
    assert_response 422
  end

  test 'should not create perennial produce due to missing name' do
    assert_no_difference('PerennialProduce.count') do
      post perennial_produces_url, params: { produce: { id: @perennial_produce.id, start_date: @perennial_produce.start_date, end_date: @perennial_produce.end_date } }
    end
    assert_response 422
  end

  test 'should not create perennial produce due to missing start_date' do
    assert_no_difference('PerennialProduce.count') do
      post perennial_produces_url, params: { produce: { id: @perennial_produce.id, name: @perennial_produce.name, end_date: @perennial_produce.end_date } }
    end
    assert_response 422
  end

  test 'should not create perennial produce due to missing end_date' do
    assert_no_difference('PerennialProduce.count') do
      post perennial_produces_url, params: { produce: { id: @perennial_produce.id, name: @perennial_produce.name, start_date: @perennial_produce.start_date } }
    end
    assert_response 422
  end

  test 'should show perennial produce' do
    post perennial_produces_url, params: { produce: { id: @perennial_produce.id, name: @perennial_produce.name, start_date: @perennial_produce.start_date, end_date: @perennial_produce.end_date } }
    get perennial_produce_url(@perennial_produce)
    assert_response :success
  end

  test 'should create annual produce' do
    assert_difference('AnnualProduce.count') do
      post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration, name: @annual_produce.name } }
    end
    assert_response :success
  end

  test 'should not create annual produce due to non-unique name' do
    post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration, name: @annual_produce.name } }
    assert_no_difference('AnnualProduce.count') do
      post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: '30', name: @annual_produce.name } }
    end
    assert_response 422
  end

  test 'should not create annual produce due to missing name' do
    assert_no_difference('AnnualProduce.count') do
      post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration } }
    end
    assert_response 422
  end

  test 'should not create annual produce due to missing duration' do
    assert_no_difference('AnnualProduce.count') do
      post annual_produces_url, params: { produce: { id: @annual_produce.id, name: @annual_produce.name } }
    end
    assert_response 422
  end

  test 'should show annual produce' do
    post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration, name: @annual_produce.name } }
    get annual_produce_url(@annual_produce)
    assert_response :success
  end

  test 'should update annual produce' do
    post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration, name: @annual_produce.name } }
    patch annual_produce_url(@annual_produce), params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration, name: @annual_produce.name } }
    assert_response :success
  end

  test 'should destroy annual produce' do
    post annual_produces_url, params: { produce: { id: @annual_produce.id, duration: @annual_produce.duration, name: @annual_produce.name } }
    assert_difference('AnnualProduce.count', -1) do
      delete annual_produce_url(@annual_produce)
    end
  end
end
