class Race < ApplicationRecord
  include Payola::Sellable

  # who create the race
  belongs_to :owner, class_name: 'User'

  # race have attendees and attendees are users
  has_many :attendees
  has_many :users, class_name: 'User', through: :attendees

  has_many :featured_races

  belongs_to :category

  enum kind: [:open, :close]

  enum status:      %i[started paused draft achieved]
  enum recipients:  %i[broker agent for_all]

  before_validation :initialize_race, on: :create
  validate          :start_in_past,   on: :create

  validates :race_value, numericality: { only_integer: true }

  validate  :date_not_changed, :category_not_changed, :commission_not_changed, on: :update

  validate  :publishability, on: :update

  # name, permalink, price validate by payola sellable. write here for not forget this.
  validates_presence_of :name, :permalink, :price,
                        :description, :commission, :recipients, :race_value, :category_id, :starts_at, :ends_at, :kind

  before_save   :sanitize_data
  after_create  :set_redirect_path

  # before_update :set_status

  # after_update  :decrement_open_race_reward, if: proc { |race| race.open? }

  after_create_commit   :subscribe_owner

  # Use like this "Race.started_races"
  scope :started_races, -> { where status: :started }
  scope :not_expired,   -> { where('ends_at > ?', DateTime.now) }
  scope :expired,       -> { where('ends_at < ?', DateTime.now) }

  scope :public_races,  -> { where(kind: :open) }
  scope :private_races, -> { where(kind: :close) }

  scope :by_category,   ->(category)  { where(category: category) }
  scope :by_owner,      ->(owner)     { where(owner: owner) }
  scope :by_recipients, ->(recipient) { where(recipients: [recipient, :for_all]) }

  def decrement_open_race_reward
    owner.reward.decrement_public_races
  end

  def likes
    Event.where(thing_type: 'Race', thing_id: id, message: 'add_like')
  end

  def completed_percentage
    value_covered.to_f / race_value.to_f * 100
  end

  # validations for publishing race
  def publishable?
    owner.valid_attribute?(:rui) and owner.has_reward?('open') ? true : false
  end

  # If owner payed for the race when publish as public race
  def payed?
    PayolaSale.find_by_product_id(id) || owner.has_plan_for_publish? ? true : false
  end

  # check by date and not by datetime for exclude race expired today
  def expired?
    ends_at.to_date < Date.today ? true : false
  end

  # Sum of all attendees join_value for this race
  def value_covered
    Attendee.where(race_id: id, status: 'confirmed').sum(:join_value)
  end

  def total_commission
    attendees.sum(:join_value) / 100 * commission
  end

  # set case and check if Owner not write prohibited data in fields like it s name or phone number
  def sanitize_data
    description.capitalize!
  end

  # create channel and subscription owner for receive notifications
  def subscribe_owner
    channel = Channel.create(name: "#{id}_race_channel")
    ChannelSubscription.create user: owner, channel: channel
  end

  def already_liked_by_user(who_did)
    if Event.where(thing_type: 'Race', thing_id: self.id, who_did: who_did, message: 'add_like').first
      true
    else
      false
    end
  end

  def add_like_of(who_did)
    unless already_liked_by_user(who_did)
      Event.create(thing_type: 'Race', thing_id: id, message: 'add_like', who_did: who_did,
                   channel: owner.private_channel, notifiable: false, read: false)
    end
  end

  def race_channel(id)
    Channel.find_or_initialize_by(name: "#{id}_race_channel")
  end

  private

  def publishability
    if self.started? or self.status == nil
      if publishable?
        self.status = :started
      else
        self.draft!
        errors.add(:not_publishable, I18n.t('activerecord.errors.models.race.not_publishable'))
      end
    end
  end

  # set redirect_path after create to redirect race after payola one time pay
  def set_redirect_path
    update_column(:redirect_path, "/races/#{id}/publish_check?kind=open")
  end

  def set_permalink
    self.permalink ||= (Faker::Coffee.blend_name.parameterize + "-" + SecureRandom.hex(3)).upcase
  end

  # create race name if not exists (need for test)
  def set_name
    self.name ||= "Gara di #{owner.name}".parameterize
  end

  def initialize_race
    set_permalink
    set_name
  end

  # CUSTOM VALIDATIONS
  def start_in_past
    if starts_at && starts_at < Date.today
      errors.add(:start_in_past, I18n.t('activerecord.errors.models.race.start_in_past'))
    end
  end

  # validation when update race
  def date_not_changed
    if starts_at_changed? || ends_at_changed? && persisted?
      errors.add(:start_and_end_cant_updated, I18n.t('activerecord.errors.models.race.start_and_end_cant_updated'))
    end
  end

  # validation when update race
  def category_not_changed
    if category_id_changed? && persisted?
      errors.add(:category_cant_updated, I18n.t('activerecord.errors.models.race.category_cant_updated'))
    end
  end

  # validation when update race
  def commission_not_changed
    if commission_changed? && persisted?
      errors.add(:commission_cant_updated, I18n.t('activerecord.errors.models.race.commission_cant_updated'))
    end
  end
end
