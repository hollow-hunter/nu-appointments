require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test 'new should be pending' do
    a = Appointment.new
    assert a.pending?, 'Appointment is not pending'
  end

  test 'should change status with symbol' do
    a = Appointment.new
    a.status = :done
    assert a.done?, 'Appointment did not change to done'
  end

  test 'should not save without client nor staff' do
    a = Appointment.new
    refute a.save, 'Appointment was saved'
    assert_not_nil a.errors.messages[:client], 'client error message is nil'
    assert_not_nil a.errors.messages[:staff], 'client error message is nil'
  end

  test 'should save with references objects' do
    c = clients(:pato)
    s = staffs(:one)
    a = Appointment.new(date: Date.new(2020, 9, 1), start_time: Time.new(2020, 9, 1, 10, 0, 0),
                        end_time: Time.new(2020, 9, 1, 11, 0, 0), client: c, staff: s)
    assert a.save, 'Appointment was not saved'
  end

  test 'should save with foreign keys' do
    c = clients(:pato)
    s = staffs(:one)
    a = Appointment.new(date: Date.new(2020, 9, 1), start_time: Time.new(2020, 9, 1, 10, 0, 0),
                        end_time: Time.new(2020, 9, 1, 11, 0, 0), client_id: c.id, staff_id: s.id)
    assert a.save, 'Appointment was not saved'
  end

  test 'should not save empty date' do
    c = clients(:pato)
    s = staffs(:one)
    a = Appointment.new(start_time: Time.new(2020, 9, 1, 10, 0, 0),
                        end_time: Time.new(2020, 9, 1, 11, 0, 0), client_id: c.id, staff_id: s.id)
    refute a.save, 'Appointment was saved'
  end

  test 'should not save with end_time lesser then start_time' do
    c = clients(:pato)
    s = staffs(:one)
    a = Appointment.new(date: Date.new(2020, 9, 1), start_time: Time.new(2020, 9, 1, 18, 0, 0),
                        end_time: Time.new(2020, 9, 1, 11, 0, 0), client_id: c.id, staff_id: s.id)
    refute a.save, 'Appointment was saved'
    assert_not_nil a.errors.messages[:end_time], 'end_time error message is nil'
  end

  test "client belongs to user's company" do
    c = clients(:lorem)
    s = staffs(:one)
    current_user = users(:owner)
    a = Appointment.new client_id: c.id, staff_id: s.id
    refute a.check_company(current_user.company_id), 'company not checked'
  end

  test "staff belongs to user's company" do
    c = clients(:pato)
    s = staffs(:two)
    current_user = users(:owner)
    a = Appointment.new client_id: c.id, staff_id: s.id
    refute a.check_company(current_user.company_id), 'company not checked'
  end
end
