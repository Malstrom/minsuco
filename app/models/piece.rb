class Piece < ApplicationRecord
  belongs_to :attendee

  validates_presence_of :name, :value, :duration
  validates :value, :duration, numericality: { only_integer: true }
end
