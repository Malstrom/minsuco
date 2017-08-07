class Race < ApplicationRecord
  include Payola::Sellable

  belongs_to :category
  belongs_to :owner, :class_name => "User"

  has_many :featured_races
  has_many :attendees
  has_many :attedees, :class_name => "User", :through => "attendees", :foreign_key => "attendee_id"

  # need for nested form
  accepts_nested_attributes_for :featured_races, allow_destroy: true

  # difference between creator pay for make public race and all can join in the race or user must pay for join in race
  enum kind:   [:pay_for_publish, :pay_for_join]

  # start or pause a race
  enum status: [:started, :paused, :draft]

  validates_presence_of :name, :description, :max_attendees, :compensation_amount,
                        :pieces_amount, :recipients, :race_value, :category_id,
                        :starts_at, :ends_at, :status, :kind

  validate :attendees_cap
  validate :start_in_past

  after_create :set_redirect_path

  before_update :publishable?, :if => :status_changed?

  # return true if race already featured
  def featured?
    true if featured_races.where("featured_races.starts_at <= ? AND featured_races.ends_at >= ?", DateTime.now, DateTime.now).first
  end

  def publishable?
    owner.have_rui? ? true : false
  end

  def payed?
    PayolaSale.find_by_product_id(id) ? true : false
  end

  private

  def start_in_past
    if starts_at and starts_at < Date.today
      errors.add(:start_in_past, "Race can't starts before today")
    end
  end

  def attendees_cap
    if max_attendees and attendees.count > max_attendees
      errors.add(:attendees_cap, "Race reached the max attendees")
    end
  end

  # set redirect_path after create to redirect race after payola one time pay
  def set_redirect_path
    update_attribute(:redirect_path, "/races/#{id}/publish_check?kind=pay_for_publish")
  end
end
