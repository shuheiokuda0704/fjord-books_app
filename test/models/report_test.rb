# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @report_one = reports(:one)
  end

  test 'editable? returns true' do
    assert_equal @user_one, @report_one.user
    assert @report_one.editable? @user_one
  end

  test 'editable? returns false' do
    assert_not @report_one.editable? @user_two
  end

  test 'created_on? returns created_at' do
    assert_equal @report_one.created_at.to_date, @report_one.created_on
  end
end
