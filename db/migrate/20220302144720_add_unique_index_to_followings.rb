# frozen_string_literal: true

class AddUniqueIndexToFollowings < ActiveRecord::Migration[6.1]
  def change
    add_index :followings, %i[user_id following_user_id], unique: true
  end
end
