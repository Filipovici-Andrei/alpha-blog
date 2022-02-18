require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: 'john', email: 'john@test.com', password: 'password')
    sign_in_as(@user)
  end

  test 'get new article form and create article' do
    get '/articles/new'
    assert_response :success

    assert_difference('Article.count', 1) do
      post articles_url, params: { article: { title: 'new article title', description: 'Article description' } }
      assert_response :redirect
    end

    follow_redirect!
    assert_response :success
    assert_match 'new article title', response.body
    assert_select 'div.alert-success'
  end

  test 'get new article form and reject invalid article submission' do
    get '/articles/new'
    assert_response :success

    assert_no_difference('Article.count') do
      post articles_url, params: { article: { title: '', description: 'Article description' } }
    end

    assert_match 'errors', response.body
    assert_select 'div.alert-danger'
    assert_select 'h4.alert-heading'
  end
end
