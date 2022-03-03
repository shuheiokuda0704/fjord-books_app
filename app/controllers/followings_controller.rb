# frozen_string_literal: true

class FollowingsController < ApplicationController
  def create
    @following = Following.new(user: current_user, following_user_id: following_params[:following_user_id])
    respond_to do |format|
      if @following.save
        format.html { redirect_to user_path(id: @following.following_user_id), notice: 'フォローしました' }
        format.json { render 'users/show', status: :created, location: @following.following_user}
      else
        format.html { redirect_to user_path(id: @following.following_user_id) }
        format.json { render json: @following.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @following = Following.find(params[:id])
    @following.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@following.following_user_id), notice: 'フォロー解除しました' }
      format.json { head :no_content }
    end
  end

  def following_params
    params.permit(:following_user_id)
  end
end
