require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  test 'name required' do
    s = Staff.new
    refute s.save, 'Staff member without name saved'
  end
end
