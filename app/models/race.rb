class Race < ApplicationRecord

  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :attendees
  has_many :attedees, :class_name => "User", :through => "attendees", :foreign_key => "attendee_id"

  validates_presence_of :start_date, :end_date

  validate :end_date_is_after_start_date

  private

  def end_date_is_after_start_date
    return if starts_at.blank? || ends_at.blank?

    if starts_at < ends_at
      errors.add(:end_date, "cannot be before the start date")
    end
  end

end
