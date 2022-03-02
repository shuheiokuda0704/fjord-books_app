class Following < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, class_name: 'User'

  validates :following_user_id, uniqueness: { scope: :user_id }
end
