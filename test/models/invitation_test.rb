require 'test_helper'

class InvitationTest < ActiveSupport::TestCase
  test 'is saved with expiration in 24 hours' do
    i = Invitation.new company_id: companies(:company_one).id
    assert i.save, "invitation wasn't saved"
    assert i.expires_in <= 24.hours.from_now, 'invitation expiration is more than 24 hours'
  end

  test 'code is generated automatically' do
    i = Invitation.new company_id: companies(:company_one).id
    assert i.save, "invitation wasn't saved"
    assert_not_nil i.code, 'invitation code was not generated'
  end

  test 'code is different for each invitation' do
    i = Invitation.new company_id: companies(:company_one).id
    i2 = Invitation.new company_id: companies(:company_one).id
    assert i.save, "invitation wasn't saved"
    assert i2.save, "invitation wasn't saved"
    assert_not_equal i.code, i2.code, 'codes were the same'
  end

  test 'invitation is expired' do
    i = Invitation.new expires_in: Time.new(2020,1,1,1,0,0)
    assert i.expired? Time.new(2020,1,2,1,0,1)
  end
end
