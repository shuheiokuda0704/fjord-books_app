# frozen_string_literal: true

require 'test_helper'

class FollowingsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @user_three = users(:three)
    @following_one_three = followings(:one_three)
  end

  test 'should create follow' do
    login_as(@user_two, scope: :user)

    assert_difference('@user_two.followings.count') do
      assert_difference('@user_one.followers.count') do
        post followings_url, params: { following_user_id: @user_one.id }
      end
    end

    assert_redirected_to user_url(@user_one)
  end

  test 'should destroy follow' do
    login_as(@user_one, scope: :user)

    assert_difference('@user_one.followings.count', -1) do
      assert_difference('@user_three.followers.count', -1) do
        delete following_url(@following_one_three.id)
      end
    end

    assert_redirected_to user_url(@user_three)
  end
end
