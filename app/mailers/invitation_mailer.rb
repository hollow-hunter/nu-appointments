class InvitationMailer < ApplicationMailer
  default from: 'invitations@nu-appointments.com'

  def invitation_created(email, code, company_name)
    @code = code
    mail(to: email, subject: "#{company_name} - NU appointments invitation")
  end
end
