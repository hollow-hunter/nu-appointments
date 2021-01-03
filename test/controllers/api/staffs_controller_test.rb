require 'test_helper'
require 'json'

module Api
  class StaffsControllerTest < ActionDispatch::IntegrationTest
    test 'index gets company staff' do
      current_user = users(:owner)
      sign_in current_user
      get api_staffs_path
      assert_equal 1, JSON.parse(response.body).size, "index didn't get all staff"
    end

    test "new can't create empty name staff" do
      current_user = users(:owner)
      sign_in current_user
      post api_staffs_path
      assert_response :bad_request
    end

    test 'empty name staff show errors' do
      current_user = users(:owner)
      sign_in current_user
      post api_staffs_path
      assert_not_nil JSON.parse(response.body)['name']
    end

    test 'correct staff' do
      current_user = users(:owner)
      sign_in current_user
      post api_staffs_path, params: { name: 'Marie' }
      assert_response :created
    end

    test 'show staff' do
      s = staffs(:one)
      current_user = users(:owner)
      sign_in current_user
      get api_staff_path(s.id)
      assert_response :ok
      edited = JSON.parse(response.body)
      assert_not_nil edited['name']
    end

    test "can't show staff from other company" do
      s = staffs(:two)
      current_user = users(:owner)
      sign_in current_user
      get api_staff_path(s.id)
      assert_response :no_content
    end

    test 'edit staff' do
      s = staffs(:one)
      current_user = users(:owner)
      sign_in current_user
      put api_staff_path(s.id), params: { name: 'Edited Mario' }
      assert_response :ok
      get api_staff_path(s.id)
      edited = JSON.parse(response.body)
      assert_equal 'Edited Mario', edited['name']
    end

    test "can't edit staff from other company" do
      s = staffs(:two)
      current_user = users(:owner)
      sign_in current_user
      put api_staff_path(s.id), params: { name: 'Edited Mario' }
      assert_response :forbidden
    end
  end
end
