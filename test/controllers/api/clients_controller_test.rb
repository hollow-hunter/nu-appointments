require 'test_helper'
require 'json'

class ClientsControllerTest < ActionDispatch::IntegrationTest
  test 'index gets all' do
    get api_clients_path
    assert_equal JSON.parse(response.body).size, clients.size, "index didn't get all staff"
  end

  test 'create client' do
    post api_clients_path, params: { name: 'new client', phone: 4444, email: 'new@new.new' }
    assert_response :created
    c = JSON.parse(response.body)
    assert_not_nil c['id'], "id wasn't provided"
    assert_equal 'new client', c['name'], "name wasn't saved"
  end

  test 'create client with bad params' do
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
end
