require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    sign_in users(:one)
    get invitations_new_url
    assert_response :success
  end

end
