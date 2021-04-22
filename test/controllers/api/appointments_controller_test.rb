require 'test_helper'
require 'json'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test 'index should get company appointments' do
    current_user = users(:owner)
    sign_in current_user
    get api_appointments_path
    assert_response :ok
    assert_equal 1, JSON.parse(response.body).size, 'index included other appointments'
  end

  test 'should create appointment' do
    c = clients(:pato)
    s = staffs(:one)
    token = api_sign_in(users(:owner))
    post api_appointments_path, params: { date: Date.new(2020, 9, 1), start_time: Time.new(2020, 9, 1, 10, 0, 0),
                                          end_time: Time.new(2020, 9, 1, 11, 0, 0), client_id: c.id, staff_id: s.id },
                                headers: { "Authorization": "Bearer #{token}" }
    assert_response :created
    created = JSON.parse(response.body)
    assert_not_nil created['id']
  end

  test "can't create appointment with client from other company" do
    c = clients(:lorem)
    s = staffs(:one)
    current_user = users(:owner)
    sign_in current_user
    post api_appointments_path, params: { date: Date.new(2020, 9, 1), start_time: Time.new(2020, 9, 1, 10, 0, 0),
                                          end_time: Time.new(2020, 9, 1, 11, 0, 0), client_id: c.id, staff_id: s.id }
    assert_response :bad_request
    created = JSON.parse(response.body)
    assert_not_nil created['clientId'], 'client is not errored'
  end

  test 'should edit appointment' do
    a = appointments(:one)
    current_user = users(:owner)
    sign_in current_user
    put api_appointment_path(a), params: { date: Date.new(2021, 10, 1) }
    assert_response :ok
    get api_appointment_path(a.id)
    edited = JSON.parse(response.body)
    assert_equal '2021-10-01', edited['date']
  end

  test 'should not edit appointment from other company' do
    a = appointments(:two)
    current_user = users(:owner)
    sign_in current_user
    put api_appointment_path(a), params: { date: Date.new(2021, 10, 1) }
    assert_response :forbidden
  end
end
