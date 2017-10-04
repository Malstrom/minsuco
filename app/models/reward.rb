class Reward < ApplicationRecord
  belongs_to :user

  before_create :set_default_rewards


  validates_presence_of :user

  def decrement_join_private
    decrement!(:join_private, 1)
  end

  def decrement_open_races
    decrement!(:open_races, 1) if open_races >= 1
  end

  private

  def set_default_rewards
    self.join_private = 3
    self.open_races = 3
  end
end
