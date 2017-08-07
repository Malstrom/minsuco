class Attendee < ApplicationRecord

  belongs_to :attendee, :class_name => 'User'
  belongs_to :race

  validate :max_attendee, :unique_join, :joinable, :self_join

  after_create_commit { create_event }

  private

  # check if attendee has permission to join the race (subscription, kind of race, free join token, ecc...)
  def joinable
    unless attendee.has_plan_for_join? or attendee.has_reward?('pay_for_join')
      errors.add(:joinable, "Non è possibile partecipare alla gara, controlla se il tuo abbonamento lo prevede")
    end
  end

  def self_join
    if race.owner_id == attendee_id
      errors.add(:self_join, "A user cannot be an attendee of its race")
    end
  end

  def max_attendee
    if race.attendees.count >= race.max_attendees
      errors.add(:max_attendee, "Race reach max attedee")
    end
  end

  def unique_join
    if Attendee.exists?(attendee: attendee, race: race)
      errors.add(:unique_join, "User must join only one time")
    end
  end

  # create event every type create attendee
  def create_event
    Event.create(thing_type: 'Attendee', thing_id:id, message:'join in race',
                 owner: attendee, recipient: race.owner,
                 notifiable: true, read: false
    )
  end
end
