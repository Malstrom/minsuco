class Channel < ApplicationRecord
  has_many :channel_subscriptions
  has_many :users, class_name: 'User', through: :channel_subscriptions
  has_many :events


end
