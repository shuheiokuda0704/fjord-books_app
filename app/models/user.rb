# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followings, dependent: :destroy
  has_many :followers, class_name: :Following, foreign_key: :following_user_id, inverse_of: :following_user, dependent: :destroy

  has_many :following_users, through: :followings, source: :following_user
  has_many :follower_users, through: :followers, source: :user

  has_one_attached :avatar
end
