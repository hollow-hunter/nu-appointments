require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  test 'invitation is saved with expiration in 24 hours' do
    i = Invitation.new company_id: companies(:company_one).id
    assert i.save, "invitation wasn't saved"
    assert i.expires_in <= 24.hours.from_now, 'invitation expiration is more than 24 hours'
  end
end
