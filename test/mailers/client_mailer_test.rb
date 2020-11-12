require 'test_helper'

class ClientMailerTest < ActionMailer::TestCase
  test 'confirmation' do
    # Create the email and store it for further assertions
    appointment = appointments(:one)
    email = ClientMailer.appointment_created(appointment.client, appointment)

    # Send the email, then test that it got queued
    assert_emails 1 do
      email.deliver_now
    end

    # Test the body of the sent email contains what we expect it to
    assert_equal ['notifications@nu-appointments.com'], email.from
    assert_equal ['pato@icloud.com'], email.to
    assert_equal 'Appointment Confirmation', email.subject
  end
end
