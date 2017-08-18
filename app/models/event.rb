class Event < ApplicationRecord
  after_create_commit :broadcast_event

  belongs_to :who_did, :class_name => "User"
  belongs_to :channel

  private

  def broadcast_event
    EventsMailer.deliver_event_mailer
    # EventBroadcastJob.perform_late self
  end
end

