# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :following_relations, class_name: :Following, dependent: :destroy
  has_many :follower_relations, class_name: :Following, foreign_key: :following_user_id, inverse_of: :following_user, dependent: :destroy

  has_many :followings, through: :following_relations, source: :following_user
  has_many :followers, through: :follower_relations, source: :user

  has_one_attached :avatar
end
