class Friend < ApplicationRecord
  belongs_to :user

  # find all users that are already registered.
  scope :in_app, -> { find_by_sql("SELECT * FROM `friends` WHERE `email` IN (SELECT `email` FROM `users`)") }
end
