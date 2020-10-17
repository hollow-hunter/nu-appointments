require 'test_helper'

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in users(:one)
    get staffs_path
    assert_response :success
  end

end
