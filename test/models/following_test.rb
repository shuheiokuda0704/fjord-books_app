require "test_helper"

class FollowingTest < ActiveSupport::TestCase
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @user_three = users(:three)
    @following_one_two = followings(:one_two)
    @following_two_three = followings(:two_three)
  end

  test 'belong_to: :user association' do
    assert_equal @user_one, @following_one_two.user
  end

  test 'belong_to: :following_user association' do
    assert_equal @user_two, @following_one_two.following_user 
  end
end
