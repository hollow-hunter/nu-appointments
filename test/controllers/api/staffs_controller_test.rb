require 'test_helper'
require 'json'

module Api
  class StaffsControllerTest < ActionDispatch::IntegrationTest
    test 'index gets all staff' do
      get api_staffs_path
      assert_equal JSON.parse(response.body).size, 2, "index didn't get all staff"
    end
  end
end
