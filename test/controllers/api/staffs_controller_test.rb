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
  end
end
