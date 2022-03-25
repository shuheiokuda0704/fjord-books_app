# frozen_string_literal: true

class CommentsController < ApplicationController
  def edit
    @comment = current_user.comments.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      redirect_to @comment.commentable, notice: t('controllers.common.notice_create_error', name: Comment.model_name.human)
    end
  end

  def update
    @comment = current_user.comments.find_by(id: params[:id])

    if @comment&.update(comment_params)
      redirect_to @comment.commentable, notice: t('controllers.common.notice_update', name: Comment.model_name.human)
    else
      redirect_to Comment.find(params[:id]).commentable, notice: t('controllers.common.notice_update_error', name: Comment.model_name.human)
    end
  end

  def destroy
    @comment = current_user.comments.find_by(id: params[:id])

    if @comment&.destroy
      redirect_to @comment.commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
    else
      redirect_to Comment.find(params[:id]).commentable, notice: t('controllers.common.notice_destroy_error', name: Comment.model_name.human)
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:comment, :user_id, :commentable_id, :commentable_type)
  end
end
