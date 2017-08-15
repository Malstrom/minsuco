class Reward < ApplicationRecord
  belongs_to :user

  def decrement_join_private
    decrement!(:join_private, 1)
  end
end
