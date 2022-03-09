# frozen_string_literal: true

class Users::FollowersController < ApplicationController
  def index
    @title = t('views.followings.followers')
    @user = User.find(params[:user_id])
    @users = @user.followers.with_attached_avatar.order(:id).page(params[:page])

    render 'users/index'
  end
end
