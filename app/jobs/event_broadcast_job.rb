class EventBroadcastJob < ApplicationJob
  queue_as :default

  def perform(event)
    # ActionCable.server.broadcast User.find(event.recipient_id).id, message: render_event(event)
  end

  private

  def render_event(event)
    ApplicationController.renderer.render(partial: 'events/event', locals: { event: event })
  end
end
