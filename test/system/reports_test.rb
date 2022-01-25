# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    @user = users(:one)
    @report = reports(:one)
  end

  test 'visiting the index' do
    login_as(@user, scope: :user)

    visit reports_url

    assert_selector 'h1', text: Report.model_name.human
  end

  test 'creating a Report' do
    login_as(@user, scope: :user)

    visit reports_url
    click_on I18n.t('views.common.new')

    fill_in I18n.t('activerecord.attributes.report.title'), with: @report.title
    fill_in I18n.t('activerecord.attributes.report.content'), with: @report.content
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Report.model_name.human)
    click_on I18n.t('views.common.back')
  end

  test 'updating a Report' do
    login_as(@user, scope: :user)

    visit reports_url
    click_on I18n.t('views.common.edit'), match: :prefer_exact

    fill_in I18n.t('activerecord.attributes.report.title'), with: @report.title
    fill_in I18n.t('activerecord.attributes.report.content'), with: @report.content
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('controllers.common.notice_update', name: Report.model_name.human)
    click_on I18n.t('views.common.back')
  end

  test 'destroying a Report' do
    login_as(@user, scope: :user)

    visit reports_url
    page.accept_confirm do
      click_on  I18n.t('views.common.destroy'), match: :first
    end

    assert_text I18n.t('controllers.common.notice_destroy', name: Report.model_name.human)
  end
end
