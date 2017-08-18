class Event < ApplicationRecord
  after_create_commit { EventBroadcastJob.perform_late self }

  belongs_to :who_did, :class_name => "User"
  belongs_to :channel
end
