require "test_helper"

class UserCompanyTest < ActionDispatch::IntegrationTest
  test 'user creates company a registers staff' do
    token = api_sign_in(users(:one))
    post api_companies_path, params: { name: 'new inc.' },
                             headers: { "Authorization": "Bearer #{token}" }
    assert_response :created
    c = JSON.parse(response.body)
    post api_staffs_path, params: { name: 'Marie' },
                          headers: { "Authorization": "Bearer #{token}" }
    assert_response :created
    s = JSON.parse(response.body)
    assert_equal c['id'], s['companyId'], "Staff doesn't belong to the company"
  end
end
