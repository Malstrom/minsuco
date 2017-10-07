class Piece < ApplicationRecord
  belongs_to :attendee


  validates_presence_of :name, :value, :duration
  validates :value, :duration, numericality: { only_integer: true }

  validate :race_value_cap

  def revenue
    if commission
      value / 100 * commission.value
    else
      0
    end
  end

  def commission
    attendee.race.commissions.find_by_duration(duration)
  end

  private

  def race_value_cap
    if value.is_a?(Integer) and attendee.race.value_covered + value > attendee.race.race_value
      errors.add(:race_target_cap, I18n.t('activerecord.errors.models.attendee.race_target_cap'))
    end
  end
end
