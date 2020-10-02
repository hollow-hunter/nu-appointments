require 'test_helper'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get clients_path
    assert_response :success
  end

  test 'should get create' do
    get new_client_path
    assert_response :success
  end

  test 'should get update' do
    get edit_client_path(1)
    assert_response :success
  end
end
