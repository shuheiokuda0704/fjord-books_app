# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::IntegrationHelpers # Rails >= 5

  setup do
    @user = users(:one)
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test 'should get index' do
    sign_in @user

    get users_url
    assert_response :success
  end

  test 'should get show' do
    sign_in @user

    get user_url(@user)
    assert_response :success
  end
end
