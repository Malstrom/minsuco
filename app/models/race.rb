class Race < ApplicationRecord
  belongs_to :user

  has_many :attendees
  has_many :users, :through => :attendees

end
