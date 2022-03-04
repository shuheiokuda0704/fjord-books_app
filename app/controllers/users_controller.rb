# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @title = User.model_name.human
    @users = User.with_attached_avatar.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @follow = Following.find_by(user: current_user, following_user: @user)
  end

  def followings
    @title = 'フォロー中'
    @user = User.find(params[:id])
    @users = @user.followings.with_attached_avatar.order(:id).page(params[:page])

    render 'index'
  end

  def followers
    @title = 'フォロワー'
    @user = User.find(params[:id])
    @users = @user.followers.with_attached_avatar.order(:id).page(params[:page])

    render 'index'
  end
end
