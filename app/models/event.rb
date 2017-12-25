class Event < ApplicationRecord
  after_create_commit :broadcast_event

  belongs_to :who_did, :class_name => "User"
  belongs_to :channel

  # todo: maybe improve assign icon and messages
  def icon
    case message
      when "join_in_race"
        "icon-user-follow"
      when "leave_from_race"
        "icon-user-unfollow"
      when init_reward_open_race
        "fa fa-gift"
      when init_reward_join_private
        "fa fa-gift"
      else
        "icon-user"
    end
  end

  # return name of event thing when exists or race not found.
  def thing
    case thing_type
      when 'Attendee'
        attendee = Attendee.find_by_id(thing_id)
        attendee ? attendee.race.permalink : "gara non trovata"
      when 'Race'
        race = Race.find_by_id(thing_id)
        race ? race.permalink : "gara non trovata"
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

