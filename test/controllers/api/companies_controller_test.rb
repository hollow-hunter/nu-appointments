require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test 'should create' do
    post api_companies_path, params: { name: 'new inc.' }
    assert_response :created
  end
end
