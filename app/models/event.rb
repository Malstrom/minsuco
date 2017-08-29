class Event < ApplicationRecord
  after_create_commit :broadcast_event

  belongs_to :who_did, :class_name => "User"
  belongs_to :channel

  def thing
    case thing_type
      when 'Attendee'
        attendee = Attendee.find_by_id(thing_id)
        attendee ? attendee.race.name : "gara non trovata"
      when 'Race'
        race = Race.find_by_id(thing_id)
        race ? race.name : "gara non trovata"
      else
        false
    end
  end

  private

  def broadcast_event
    EventsMailer.event_mailer(self).deliver_later
    # EventBroadcastJob.perform_late self
  end
end

