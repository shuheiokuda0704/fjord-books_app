# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Warden::Test::Helpers

  setup do
    @user_one = users(:one)
    @user_two = users(:two)
    @book1 = books(:one)
    @comment_book1user1 = comments(:book1user1)
    @comment_book2user1 = comments(:book2user1)
  end

  test 'should update comment' do
    login_as(@user_one, scope: :user)

    assert_no_difference('Comment.count') do
      patch book_comment_url(@book1, @comment_book1user1), params: { comment: { comment: @comment_book2user1.comment } }
    end

    comment = Comment.find(@comment_book1user1.id)

    assert_response :redirect
    assert_equal @comment_book2user1.comment, comment.comment
    assert_redirected_to book_url(@book1)
  end

  test "should not update report for other user's report" do
    login_as(@user_two, scope: :user)

    assert_no_difference('Comment.count') do
      patch book_comment_url(@book1, @comment_book1user1), params: { comment: { comment: @comment_book2user1.comment } }
    end

    comment = Comment.find(@comment_book1user1.id)

    assert_response :redirect
    assert_equal @comment_book1user1.comment, comment.comment
    assert_redirected_to book_url(@book1)
  end

  test 'should destroy user own comment' do
    login_as(@user_one, scope: :user)

    assert_difference('Comment.count', -1) do
      delete book_comment_url(@book1, @comment_book1user1)
    end
    assert_response :redirect
    assert_redirected_to book_url(@book1)
  end

  test 'should not destroy other user\'s comment' do
    login_as(@user_two, scope: :user)

    assert_no_difference('Comment.count') do
      delete book_comment_url(@book1, @comment_book1user1)
    end
    assert_response :redirect
    assert_redirected_to book_url(@book1)
  end
end
