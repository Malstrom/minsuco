class Race < ApplicationRecord

  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :featured_races
  has_many :attendees
  has_many :attedees, :class_name => "User", :through => "attendees", :foreign_key => "attendee_id"


  validates_presence_of :starts_at, :ends_at

  # validate :start_in_past

  private

  def start_in_past
    if starts_at < Date.today
      errors.add(:start_in_past, "Race can't starts before today")
    end
  end

end
