require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test 'new user sign up' do
    get '/signup'
    assert_response :success

    assert_difference('User.count', 1) do
      post users_url, params: { user: { username: 'Jim', email: 'jim@example.com', password: 'password' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match 'Jim', response.body
  end
end
