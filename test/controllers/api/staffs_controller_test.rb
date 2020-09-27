require 'test_helper'
require 'json'

module Api
  class StaffsControllerTest < ActionDispatch::IntegrationTest
    test 'index gets all staff' do
      get api_staffs_path
      assert_equal JSON.parse(response.body).size, 2, "index didn't get all staff"
    end

    test "new can't create empty name staff" do
      post api_staffs_path
      assert_response :bad_request
    end

    test 'empty name staff show errors' do
      post api_staffs_path
      assert_not_nil JSON.parse(response.body)['name']
    end

    test 'correct staff' do
      post api_staffs_path, params: { name: 'Marie' }
      assert_response :created
    end

    test 'show staff' do
      s = staffs(:one)
      get api_staff_path(s.id)
      assert_response :ok
      edited = JSON.parse(response.body)
      assert_not_nil edited['name']
    end

    test 'edit staff' do
      s = staffs(:one)
      put api_staff_path(s.id), params: { name: 'Edited Mario' }
      assert_response :ok
      get api_staff_path(s.id)
      edited = JSON.parse(response.body)
      assert_equal 'Edited Mario', edited['name']
    end
  end
end
