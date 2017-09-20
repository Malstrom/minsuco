class Piece < ApplicationRecord
  belongs_to :attendee


  validates_presence_of :name, :value, :duration
  validates :value, :duration, numericality: { only_integer: true }

  validate :race_value_cap

  def total_revenue
    sum = 0
    attendee.race.commissions.each do |commission|
      sum += revenue(commission)
    end
    sum
  end

  def revenue(commission)
    if duration < commission.ends
      years = (duration - commission.starts )
    else
      years = (commission.ends - commission.starts )
    end
    years > 0 ? value / 100 * commission.value * years : 0
  end

  private

  def race_value_cap
    if attendee.race.value_covered + value > attendee.race.race_value
      errors.add(:race_target_cap, I18n.t('activerecord.errors.models.attendee.race_target_cap'))
    end
  end
end
