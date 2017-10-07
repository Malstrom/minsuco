class Commission < ApplicationRecord
  belongs_to :race

  # find nearest commission by duration
  scope :find_by_duration,  ->(duration) { where("duration < ?", duration).order("ABS( duration - #{duration} )").max}

  scope :best,   -> { order('value DESC') }
  scope :worst,  -> { order('value DESC') }
end
