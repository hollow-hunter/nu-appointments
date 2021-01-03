require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'name is required' do
    a = Company.new
    refute a.save
    assert_not_nil a.errors[:name]
  end
end
