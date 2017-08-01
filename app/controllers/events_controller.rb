class EventsController < ApplicationController
  def readed
    event = Event.find(params[:id])

    event.update_attribute(:read, true)

    if event.thing_type == 'Attendee' and Attendee.exists?(id: event.thing_id)
      attendee = Attendee.find(event.thing_id)
      race = Race.find(attendee.race.id)

      redirect_to race_path(race)
    elsif event.thing_type == 'Race' and Race.exists?(id: event.thing_id)
      race = Race.find(event.thing_id)

      redirect_to race_path(race)
    else
      flash[:warning] = "Notifica scaduta!"
      redirect_to root_path
    end
  end
end
