# frozen_string_literal: true

require 'test_helper'

class ReportsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @report_one = reports(:one)
    @report_two = reports(:two)
  end

  test 'should redirect to login_page if not lgged in' do
    get reports_url

    assert_response :redirect
    assert_redirected_to new_user_session_url
  end

  test 'should get index' do
    login_as(@user_one, scope: :user)

    get reports_url
    assert_response :success
  end

  test 'should get new' do
    login_as(@user_one, scope: :user)

    get new_report_url
    assert_response :success
  end

  test 'should create report' do
    login_as(@user_one, scope: :user)

    assert_difference('Report.count') do
      post reports_url, params: { report: { content: @report_one.content, title: @report_one.title } }
    end

    assert_redirected_to report_url(Report.last)
  end

  test 'should show report' do
    login_as(@user_one, scope: :user)

    get report_url(@report_one)
    assert_response :success
  end

  test 'should get edit' do
    login_as(@user_one, scope: :user)

    get edit_report_url(@report_one)
    assert_response :success
  end

  test "should not get edit for other user's report" do
    login_as(@user_two, scope: :user)

    get edit_report_url(@report_one)

    assert_response :redirect
    assert_redirected_to report_url(@report_one)
  end

  test 'should update report' do
    login_as(@user_one, scope: :user)

    assert_no_difference('Report.count') do
      patch report_url(@report_one), params: { report: { content: @report_two.content, title: @report_two.title } }
    end

    report = Report.find(@report_one.id)

    assert_equal @report_two.title, report.title
    assert_equal @report_two.content, report.content
    assert_redirected_to report_url(@report_one)
  end

  test "should not update report for other user's report" do
    login_as(@user_two, scope: :user)

    assert_no_difference('Report.count') do
      patch report_url(@report_one), params: { report: { content: @report_two.content, title: @report_two.title } }
    end

    report = Report.find(@report_one.id)

    assert_response :redirect
    assert_equal @report_one.title, report.title
    assert_equal @report_one.content, report.content
    assert_redirected_to report_url(@report_one)
  end

  test 'should destroy report' do
    login_as(@user_one, scope: :user)

    assert_difference('Report.count', -1) do
      delete report_url(@report_one)
    end

    assert_redirected_to reports_url
  end

  test "should not destroy other user's report" do
    login_as(@user_two, scope: :user)

    assert_no_difference('Report.count') do
      delete report_url(@report_one)
    end

    assert_redirected_to report_url(@report_one)
  end
end
