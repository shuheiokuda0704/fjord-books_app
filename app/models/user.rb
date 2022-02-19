# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar do |attachable|
    attachable.variant :normal, resize: "300x300"
    attachable.variant :thumbnail, resize: "100x100"
  end
end
