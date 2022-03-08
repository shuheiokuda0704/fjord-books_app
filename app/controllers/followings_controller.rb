# frozen_string_literal: true

class FollowingsController < ApplicationController
  def create
    @following = Following.new(user: current_user, following_user_id: following_params[:following_user_id])

    if @following.save
      redirect_to user_path(id: @following.following_user_id), notice: t('controllers.followings.notice_create')
    else
      redirect_to user_path(id: @following.following_user_id)
    end
  end

  def destroy
    @following = Following.find(params[:id])
    @following.destroy

    redirect_to user_path(@following.following_user_id), notice: t('controllers.followings.notice_destroy')
  end

  def following_params
    params.permit(:following_user_id)
  end
end
