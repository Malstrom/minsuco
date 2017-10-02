class EventsController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def readed
    event = Event.find(params[:id])

    event.update(read: true)

    if event.thing_type == 'Attendee' && Attendee.exists?(id: event.thing_id)
      redirect_to race_path(Attendee.find(event.thing_id).race)
    elsif event.thing_type == 'Race' && Race.exists?(id: event.thing_id)
      redirect_to race_path(Race.find(event.thing_id))
    else
      flash[:warning] = 'Notifica scaduta!'
      redirect_to root_path
    end
  end
end
