class Event < ApplicationRecord
  after_create_commit { EventBroadcastJob.perform_later self }

  belongs_to :owner, :class_name => "User"
  belongs_to :recipient, :class_name => "User"
end
