# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @user_three_no_relations = users(:three_no_relations)
  end

  test 'followings? returns true' do
    assert @user_one.following?(@user_two)
  end

  test 'followings? returns false' do
    assert_not @user_one.following?(@user_three_no_relations)
  end

  test 'followed_by? returns true' do
    assert @user_one.followed_by?(@user_two)
  end

  test 'followed_by? returns false' do
    assert_not @user_one.followed_by?(@user_three_no_relations)
  end

  test 'follow creates new relations' do
    @user_one.follow @user_three_no_relations
    assert @user_one.following?(@user_three_no_relations)
    assert @user_three_no_relations.followed_by?(@user_one)
  end

  test 'follow finds relations' do
    @user_one.follow @user_two
    assert @user_one.following?(@user_two)
    assert @user_two.followed_by?(@user_one)
  end

  test 'unfollow destroys existing relations' do
    @user_one.unfollow @user_two
    assert_not @user_one.following?(@user_two)
    assert_not @user_two.followed_by?(@user_one)
  end

  test 'unfollow does not destroy not-existing relations' do
    @user_one.unfollow @user_three_no_relations
    assert_not @user_one.following?(@user_three_no_relations)
    assert_not @user_three_no_relations.followed_by?(@user_one)
  end

  test 'name_or_email returns name' do
    assert_equal @user_one.name, @user_one.name_or_email
  end

  test 'name_or_email returns email' do
    assert_equal @user_two.email, @user_two.name_or_email
  end
end
