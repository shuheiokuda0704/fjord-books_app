# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @user_three = users(:three)
    @following_one_two = followings(:one_two)
    @following_two_three = followings(:two_three)
    @following_one_three = followings(:one_three)
  end

  test 'has_many: :followings association' do
    assert_equal [@following_one_two.id, @following_one_three.id].sort, @user_one.followings.map(&:id).sort
  end

  test 'has_many: :followers association' do
    assert_equal [@following_two_three.id, @following_one_three.id].sort, @user_three.followers.map(&:id).sort
  end

  test 'has_many: :following_users association' do
    assert_equal [@user_two.id, @user_three.id].sort, @user_one.following_users.map(&:id).sort
  end

  test 'has_many: :follower_users association' do
    assert_equal [@user_one.id, @user_two.id].sort, @user_three.follower_users.map(&:id).sort
  end
end
