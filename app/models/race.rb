class Race < ApplicationRecord
  include Payola::Sellable

  belongs_to :category
  belongs_to :owner, class_name: 'User'

  has_many :featured_races

  has_many :attendees
  has_many :users, class_name: 'User', through: :attendees

  # need for nested form
  accepts_nested_attributes_for :featured_races, allow_destroy: true

  # difference between creator pay for make public race and all can join in the race or user must pay for join in race
  enum kind:   %i[pay_for_publish pay_for_join]

  # start or pause a race
  enum status: %i[started paused draft achieved]

  before_validation :set_permalink, on: :create

  validates_presence_of :name, :description, :max_attendees, :compensation_amount,
                        :pieces_amount, :recipients, :race_value, :category_id,
                        :starts_at, :ends_at, :status, :kind
  validate :attendees_cap
  validate :start_in_past, on: :create
  validate :publishable?, if: :saved_change_to_status?, on: :update

  after_create :set_redirect_path

  def value_coverage
    Attendee.where(race_id:self.id).sum(:join_value)
  end

  # return true if race already featured
  def featured?
    true if featured_races.where('featured_races.starts_at <= ? AND featured_races.ends_at >= ?', DateTime.now, DateTime.now).first
  end

  def payed?
    PayolaSale.find_by_product_id(id) || owner.has_plan_for_publish? ? true : false
  end

  private

  def publishable?
    unless owner.have_rui? and status == 'started'
      errors.add(:not_publishable, I18n.t('activerecord.errors.models.race.not_publishable'))
    end
  end

  def start_in_past
    if starts_at && starts_at < Date.today
      errors.add(:start_in_past, I18n.t('activerecord.errors.models.race.start_in_past'))
    end
  end

  def attendees_cap
    if max_attendees && attendees.count > max_attendees
      errors.add(:attendees_cap, I18n.t('activerecord.errors.models.race.attendees_cap'))
    end
  end

  # set redirect_path after create to redirect race after payola one time pay
  def set_redirect_path
    update(redirect_path: "/races/#{id}/publish_check?kind=pay_for_publish")
  end

  def set_permalink
    self.permalink = "#{Time.now.to_i}-#{name.parameterize}"
  end
end
