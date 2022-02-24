# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @user = users(:one)
  end

  test 'should get index' do
    sign_in @user

    get users_url
    assert_response :success
  end

  test 'should redirect when not logged in (index)' do
    get users_url
    assert_response :redirect
  end

  test 'should get show' do
    sign_in @user

    get user_url(@user)
    assert_response :success
  end

  test 'should redirect when not logged in (show)' do
    get user_url(@user)
    assert_response :redirect
  end
end
