class Race < ApplicationRecord

  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :attendees
  has_many :owners, :class_name => "User", :through => "attendees", :foreign_key => "attendee_id"

end
