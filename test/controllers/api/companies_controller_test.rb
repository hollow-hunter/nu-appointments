require 'test_helper'

class CompaniesControllerTest < ActionDispatch::IntegrationTest
  test 'should create' do
    sign_in users(:one)
    post api_companies_path, params: { name: 'new inc.' }
    assert_response :created
  end

  test 'should associate user to company' do
    current_user = users(:one)
    sign_in current_user
    post api_companies_path, params: { name: 'new inc.' }
    c = JSON.parse(response.body)
    assert_equal c['id'], current_user.company_id
  end
end
