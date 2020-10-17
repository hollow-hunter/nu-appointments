require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    sign_in users(:one)
    get clients_path
    assert_response :success
  end

  test 'should get create' do
    sign_in users(:one)
    get new_client_path
    assert_response :success
  end

  test 'should get update' do
    sign_in users(:one)
    get edit_client_path(1)
    assert_response :success
  end
end
