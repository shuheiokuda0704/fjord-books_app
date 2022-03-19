require "test_helper"

class CommentTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @book1 = books(:one)
    @report = reports(:one)
    @comment_book1user1 = comments(:book1user1)
    @comment_report1user1 = comments(:report1user1)
  end

  test "comment is invalid if no comment text" do
    comment = Comment.new()
    assert_not comment.valid?

    comment = Comment.new(user_id: 1, commentable_id: 1, commentable_type: 'Book')
    assert_not comment.valid?

    comment = Comment.new(user_id: 1, commentable_id: 1, comment: "comment")
    assert_not comment.valid?

    comment = Comment.new(user_id: 1, commentable_type: 'Book', comment: "comment")
    assert_not comment.valid?

    comment = Comment.new(commentable_id: 1, commentable_type: 'Book', comment: "comment")
    assert_not comment.valid?

    comment = Comment.new(user_id: 1, commentable_id: 1, commentable_type: 'Book', comment: "comment")
    assert comment.valid?
  end

  test "comment has comment" do
    assert_equal "book1-user1", @comment_book1user1.comment
  end

  test "comment belongs to book" do
    assert_equal @book1, @comment_book1user1.commentable
  end

  test "comment belongs to report" do
    assert_equal @report1, @comment_report1user1.commentable
  end

  test "comment belongs to user" do
    assert_equal @user1, @comment_report1user1.user
  end
end
