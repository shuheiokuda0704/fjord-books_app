# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test 'to get attributes' do
    assert_equal @user.email, 'test1@test.com'
    assert_equal @user.zipcode, '1111111'
    assert_equal @user.address, '渋谷区1'
    assert_equal @user.introduction, '1です'
  end
end
