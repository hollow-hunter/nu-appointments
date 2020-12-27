require 'test_helper'

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index for user with company' do
    sign_in users(:owner)
    get staffs_path
    assert_response :success
  end

  test 'user without company is redirected to index' do
    sign_in users(:one)
    get staffs_path
    assert_redirected_to root_path
  end
end
