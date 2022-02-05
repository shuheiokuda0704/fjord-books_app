# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  include Warden::Test::Helpers

  setup do
    @user = users(:one)
    @book = books(:one)
  end

  test 'visiting the index' do
    login_as(@user, scope: :user)

    visit books_url
    assert_selector 'h1', text: Book.model_name.human
  end

  test 'creating a Book' do
    login_as(@user, scope: :user)

    visit books_url
    click_on I18n.t('views.common.new')

    fill_in I18n.t('activerecord.attributes.book.memo'), with: @book.memo
    fill_in I18n.t('activerecord.attributes.book.title'), with: @book.title
    click_on I18n.t('helpers.submit.create')

    assert_text I18n.t('controllers.common.notice_create', name: Book.model_name.human)
    click_on I18n.t('views.common.back')
  end

  test 'updating a Book' do
    login_as(@user, scope: :user)

    visit books_url
    click_on I18n.t('views.common.edit'), match: :prefer_exact

    fill_in I18n.t('activerecord.attributes.book.memo'), with: @book.memo
    fill_in I18n.t('activerecord.attributes.book.title'), with: @book.title
    click_on I18n.t('helpers.submit.update')

    assert_text I18n.t('controllers.common.notice_update', name: Book.model_name.human)
    click_on I18n.t('views.common.back')
  end

  test 'destroying a Book' do
    login_as(@user, scope: :user)

    visit books_url
    page.accept_confirm do
      click_on I18n.t('views.common.destroy'), match: :first
    end

    assert_text I18n.t('controllers.common.notice_destroy', name: Book.model_name.human)
  end
end
