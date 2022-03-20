# frozen_string_literal: true

require 'application_system_test_case'

class CommentsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @comment_report1_user1 = comments(:report1user1)

    @user_one = users(:one)
    sign_in @user_one
  end

  test 'creating a Comment for a Report' do
    visit reports_url
    click_on '詳細', match: :first

    fill_in 'コメント', with: @comment_report1_user1.comment
    click_on '登録する'

    assert_text 'コメントが作成されました。'
    click_on '戻る'
  end

  test 'updating a Comment for a Report' do
    visit reports_url

    click_on '詳細', match: :first

    sleep 1 # Wait a 1 sec to render "編集" for comments

    click_on '編集', match: :prefer_exact

    fill_in 'コメント', with: @comment_report1_user1.comment
    click_on '更新する'

    assert_text 'コメントが更新されました。'
    click_on '戻る'
  end

  test 'destroying a Comment for a Report' do
    visit reports_url
    click_on '詳細', match: :first

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text 'コメントが削除されました。'
  end

  test 'creating a Comment for a Book' do
    visit books_url
    click_on '詳細', match: :first

    fill_in 'コメント', with: @comment_report1_user1.comment
    click_on '登録する'

    assert_text 'コメントが作成されました。'
    click_on '戻る'
  end

  test 'updating a Comment for a Book' do
    visit books_url

    click_on '詳細', match: :first

    sleep 1 # Wait a 1 sec to render "編集" for comments

    click_on '編集', match: :prefer_exact

    fill_in 'コメント', with: @comment_report1_user1.comment
    click_on '更新する'

    assert_text 'コメントが更新されました。'
    click_on '戻る'
  end

  test 'destroying a Comment for a Book' do
    visit books_url
    click_on '詳細', match: :first

    page.accept_confirm do
      click_on '削除', match: :first
    end

    assert_text 'コメントが削除されました。'
  end
end
