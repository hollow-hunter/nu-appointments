class ClientMailer < ApplicationMailer
  default from: 'notifications@nu-appointments.com'

  def appointment_created(client, appointment)
    @client = client
    @appointment = appointment
    mail(to: @client.email, subject: 'Appointment Confirmation')
  end
end
