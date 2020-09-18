require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index as root" do
    get root_path
    assert_response :success
  end

end
