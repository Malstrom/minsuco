class EventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(event)
    # EventsMailer.deliver_event(event)
    # ActionCable.server.broadcast User.find(event.recipient_id).id, message: render_event(event)
  end

  private
end
