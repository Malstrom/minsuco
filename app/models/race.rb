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

  validates_presence_of :name, :description, :max_attendees, :commission,
                        :pieces_amount, :recipients, :race_value, :category_id,
                        :starts_at, :ends_at, :kind

  validate :attendees_cap
  validate :start_in_past, on: :create

  validate :date_not_changed, :category_not_changed, :commission_not_changed, :on => :update

  # validate :publishable, if: :saved_change_to_status?, on: :update

  # validates_associated :owner

  before_create :set_status
  before_save :upcase_name
  after_create :set_redirect_path

  after_create_commit :subscribe_owner

  def set_status
    if publishable?
      self.status = 'started'
    else
      self.status = 'draft'
    end
  end

  def value_coverage
    Attendee.where(race_id:self.id, status: 'confirmed').sum(:join_value)
  end

  # return true if race already featured
  def featured?
    true if featured_races.where('featured_races.starts_at <= ? AND featured_races.ends_at >= ?', DateTime.now, DateTime.now).first
  end

  def payed?
    PayolaSale.find_by_product_id(id) || owner.has_plan_for_publish? ? true : false
  end

  def publishable?
    owner.have_rui? ? true : false
  end

  def upcase_name
    self.name.upcase!
  end

  private

  def date_not_changed
    if starts_at_changed? or ends_at_changed? && self.persisted?
      errors.add(:activity_id, "Change of activity_id not allowed!")
    end
  end

  def category_not_changed
    if category_id_changed? && self.persisted?
      errors.add(:activity_id, "Change of activity_id not allowed!")
    end
  end

  def commission_not_changed
    if commission_changed? && self.persisted?
      errors.add(:activity_id, "Change of activity_id not allowed!")
    end
  end

  def publishable
    unless publishable?
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
    update(redirect_path: "/races/#{self.id}/publish_check?kind=pay_for_publish")
  end

  def set_permalink
    self.permalink = "#{Time.now.to_i}-#{name.parameterize}"
  end

  #create channel and subscription owner for receive notifications
  def subscribe_owner
    channel = Channel.create(name: "#{id}_race_channel")
    ChannelSubscription.create user:owner, channel: channel
  end
end
