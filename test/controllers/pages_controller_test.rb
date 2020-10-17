require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index as root" do
    sign_in users(:one)
    get root_path
    assert_response :success
  end

end
