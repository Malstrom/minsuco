class Attendee < ApplicationRecord

  belongs_to :attendee, :class_name => 'User'
  belongs_to :race

  validate :self_join
  validate :max_attendee
  validate :unique_join

  private

  def self_join
    if self.race.owner_id == self.attendee_id
      errors.add(:self_join, "A user cannot be an attendee of its race")
    end
  end

  def max_attendee
    if self.race.attendees.count >= self.race.max_attendees
      errors.add(:self_join, "Race reach max attedee")
    end
  end

  def unique_join
    if Attendee.where(attendee: self.attendee, race:self.race)
      errors.add(:self_join, "User must join only one time")
    end
  end
end
