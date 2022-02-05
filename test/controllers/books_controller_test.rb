# frozen_string_literal: true

require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    @user = users(:one)
    @book = books(:one)
  end

  test 'should get index' do
    login_as(@user, scope: :user)

    get books_url
    assert_response :success
  end

  test 'should get new' do
    login_as(@user, scope: :user)

    get new_book_url
    assert_response :success
  end

  test 'should create book' do
    login_as(@user, scope: :user)

    assert_difference('Book.count') do
      post books_url, params: { book: { memo: @book.memo, title: @book.title } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test 'should show book' do
    login_as(@user, scope: :user)

    get book_url(@book)
    assert_response :success
  end

  test 'should get edit' do
    login_as(@user, scope: :user)

    get edit_book_url(@book)
    assert_response :success
  end

  test 'should update book' do
    login_as(@user, scope: :user)

    patch book_url(@book), params: { book: { memo: @book.memo, title: @book.title } }
    assert_redirected_to book_url(@book)
  end

  test 'should destroy book' do
    login_as(@user, scope: :user)

    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
