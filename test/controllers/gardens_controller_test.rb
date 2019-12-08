require 'test_helper'

class GardensControllerTest < ActionDispatch::IntegrationTest
  setup do
    @garden = gardens(:one)
  end

  test 'should get index' do
    get gardens_url
    assert_response :success
  end

  test 'should create garden' do
    assert_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response :success
  end

  test 'should create garden with contact number 1 only' do
    assert_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response :success
  end

  test 'should create garden with email 1 only' do
    assert_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response :success
  end

  test 'should create garden with contact number 2 only' do
    assert_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, image: @garden.image, } }
    end
    assert_response :success
  end

  test 'should create garden with email 2 only' do
    assert_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response :success
  end

  test 'should not create garden due to missing name' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to missing address' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to missing lat' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to missing long' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to missing contact name 1' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to missing contact number 1 and email 1' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1,
                                            contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to missing contact number 2 and email 2' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to wrong name format' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: '0wrongname0', address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to wrong email 1 format' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: 'wrongemailformat', contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to wrong email 2 format' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: 'wrongemailformat', image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to wrong contact number 1 format' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: '01234567890',
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should not create garden due to wrong contact number 2 format' do
    assert_no_difference('Garden.count') do
      post gardens_url, params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                            email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: '01234567890', email_2: @garden.email_2, image: @garden.image, } }
    end
    assert_response 422
  end

  test 'should show garden' do
    get garden_url(@garden)
    assert_response :success
  end

  test 'should update garden' do
    patch garden_url(@garden), params: { garden: { name: @garden.name, address: @garden.address, lat: @garden.lat, long: @garden.long, contact_name_1: @garden.contact_name_1, contact_number_1: @garden.contact_number_1,
                                                   email_1: @garden.email_1, contact_name_2: @garden.contact_name_2, contact_number_2: @garden.contact_number_2, email_2: @garden.email_2, image: @garden.image, } }
    assert_response :success
  end

  test 'should destroy garden' do
    assert_difference('Garden.count', -1) do
      delete garden_url(@garden)
    end
  end
end
