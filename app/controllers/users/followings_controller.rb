# frozen_string_literal: true

class Users::FollowingsController < ApplicationController
  def index
    @title = t('views.followings.followings')
    @user = User.find(params[:user_id])
    @users = @user.followings.with_attached_avatar.order(:id).page(params[:page])

    render 'users/index'
  end
end
