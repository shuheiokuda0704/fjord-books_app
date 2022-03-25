# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  setup do
    @report = reports(:one)
    @user = users(:one)
  end

  test 'report has title and content' do
    assert_equal 'title-one', @report.title
    assert_equal 'content-one', @report.content
  end
  test 'report belongs to user' do
    assert_equal @user, @report.user
  end
end
