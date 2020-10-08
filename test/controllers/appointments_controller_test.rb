require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get appointments_path
    assert_response :success
  end

  test 'should get new' do
    get new_appointment_path
    assert_response :success
  end
end
