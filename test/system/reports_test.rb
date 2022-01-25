# frozen_string_literal: true

require "application_system_test_case"

class ReportsTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    @user = users(:one)
  end

  test 'visiting the index' do
    login_as(@user, scope: :user)

    visit reports_url

    assert_selector 'h1', text: Report.model_name.human
  end
end
