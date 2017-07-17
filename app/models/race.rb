class Race < ApplicationRecord

  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :attendees
  has_many :attedees, :class_name => "User", :through => "attendees", :foreign_key => "attendee_id"


  validates_presence_of :starts_at, :ends_at


  private


end
