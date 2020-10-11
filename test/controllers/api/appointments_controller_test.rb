require 'test_helper'
require 'json'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  test 'index should get all' do
    get api_appointments_path
    assert_response :ok
    assert_equal JSON.parse(response.body).size, appointments.size, "index didn't get all appointments"
  end

  test 'should create appointment' do
    c = clients(:pato)
    s = staffs(:one)
    post api_appointments_path, params: { date: Date.new(2020, 9, 1), start_time: Time.new(2020, 9, 1, 10, 0, 0),
                                          end_time: Time.new(2020, 9, 1, 11, 0, 0), client_id: c.id, staff_id: s.id }
    assert_response :created
    created = JSON.parse(response.body)
    assert_not_nil created['id']
  end

  test 'should edit appointment' do
    a = appointments(:one)
    put api_appointment_path(a), params: { date: Date.new(2021, 10, 1) }
    assert_response :ok
    get api_appointment_path(a.id)
    edited = JSON.parse(response.body)
    assert_equal '2021-10-01', edited['date']
  end
end
