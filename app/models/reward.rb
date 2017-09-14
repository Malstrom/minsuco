class Reward < ApplicationRecord
  belongs_to :user

  before_create :set_default_rewards

  def decrement_join_private
    decrement!(:join_private, 1)
  end

  def decrement_public_races
    decrement!(:public_races, 1)
  end

  private

  def set_default_rewards
    self.join_private = 3
    self.public_races = 3
  end
end
