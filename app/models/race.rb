class Race < ApplicationRecord
  include PublicActivity::Model
  tracked

  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :featured_races
  has_many :attendees
  has_many :attedees, :class_name => "User", :through => "attendees", :foreign_key => "attendee_id"

  # difference between creator pay for make public race and all can join in the race or user must pay for join in race
  enum kind:   [:pay_for_publish, :pay_for_join]

  # start or pause a race
  enum status: [:started, :paused]

  validates_presence_of :starts_at, :ends_at

  validate :attendees_cap

  # validate :start_in_past

  # return true if race already featured
  def featured?
    true if featured_races.where("featured_races.starts_at <= ? AND featured_races.ends_at >= ?", DateTime.now, DateTime.now).first
  end

  private

  def start_in_past
    if starts_at < Date.today
      errors.add(:start_in_past, "Race can't starts before today")
    end
  end

  def attendees_cap
    if attendees.count > max_attendees
      errors.add(:attendees_cap, "Race reached the max attendees")
    end
  end

end
