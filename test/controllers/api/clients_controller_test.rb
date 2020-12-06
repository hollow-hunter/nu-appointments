require 'test_helper'
require 'json'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test "index gets all clients from the user's company" do
    current_user = users(:owner)
    sign_in current_user
    get api_clients_path
    assert_equal 1, JSON.parse(response.body).size, 'index got other staff'
  end

  test "create client for the user's company" do
    current_user = users(:owner)
    sign_in current_user
    post api_clients_path, params: { name: 'new client', phone: 4444, email: 'new@new.new' }
    assert_response :created
    c = JSON.parse(response.body)
    assert_not_nil c['id'], "id wasn't provided"
    assert_equal 'new client', c['name'], "name wasn't saved"
  end

  test 'create client with existing code' do
    current_user = users(:owner)
    sign_in current_user
    pato = clients(:pato)
    post api_clients_path, params: { name: 'new client', phone: 4444, email: 'new@new.new', code: pato.code }
    assert_response :bad_request
    c = JSON.parse(response.body)
    assert_not_nil c['code'], 'code is not errored'
  end

  test 'create client with bad params' do
    current_user = users(:owner)
    sign_in current_user
    post api_clients_path
    assert_response :bad_request
    c = JSON.parse(response.body)
    assert_not_nil c['name'], 'error in name param'
    assert_not_nil c['phone'], 'error in phone param'
    assert_not_nil c['email'], 'error in email param'
  end

  test 'show client' do
    s = clients(:pato)
    get api_client_path(s.id)
    assert_response :ok
    edited = JSON.parse(response.body)
    assert_not_nil edited['id']
  end

  test 'edit client' do
    s = clients(:pato)
    put api_client_path(s.id), params: { name: 'Edited Pato' }
    assert_response :ok
    get api_client_path(s.id)
    edited = JSON.parse(response.body)
    assert_equal 'Edited Pato', edited['name']
  end

  test "edit client with another client's code" do
    s = clients(:pato)
    lorem = clients(:lorem)
    put api_client_path(s.id), params: { name: 'Edited Pato', code: lorem.code }
    assert_response :bad_request
    c = JSON.parse(response.body)
    assert_not_nil c['code'], 'code is not errored'
  end

  test 'should get client by code' do
    c = clients(:pato)
    get code_api_clients_path(c.code)
    assert_response :ok
    response_client = JSON.parse(response.body)
    assert_equal c.id, response_client['id'], 'Incorrect client'
  end

  test 'should get no_content by code when not found' do
    get code_api_clients_path('usnln')
    assert_response :no_content
  end
end
