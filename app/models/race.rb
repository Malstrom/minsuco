class Race < ApplicationRecord
  include Payola::Sellable

  belongs_to :category

  # who create the race
  belongs_to :owner, class_name: 'User'

  # race have attendees and attendees are users
  has_many :attendees
  has_many :users, class_name: 'User', through: :attendees

  has_many :featured_races

  has_many :commissions
  accepts_nested_attributes_for :commissions, allow_destroy: true

  enum kind: %i[open close]

  enum status:      %i[started paused draft achieved]
  enum recipients:  %i[for_all broker agent sub_agent]

  before_validation :initialize_race, on: :create
  validate          :start_in_past,   on: :create

  validates :race_value, numericality: { only_integer: true }

  validate  :date_not_changed, :category_not_changed, on: :update

  #validate  :publishability, on: :update

  # name, permalink, price validate by payola sellable. write here for not forget this.
  validates_presence_of :name, :permalink, :price,
                        :description, :recipients, :race_value, :category_id, :starts_at, :ends_at, :kind

  before_create :set_draft
  before_save   :sanitize_data
  after_create  :set_redirect_path

  # before_update :set_status

  # after_update  :decrement_open_race_reward, if: proc { |race| race.open? }

  after_create_commit   :subscribe_owner

  # Use like this "Race.started_races"
  scope :started_races, -> { where status: :started }
  scope :achieved,      -> { where('status  < ?', :achieved) }
  scope :not_expired,   -> { where('ends_at > ?', DateTime.now) }
  scope :expired,       -> { where('ends_at < ?', DateTime.now) }

  scope :open_races,  -> { where(kind: :open) }
  scope :close_races, -> { where(kind: :close) }

  scope :by_category,   ->(category)  { where(category: category) }
  scope :by_owner,      ->(owner)     { where(owner: owner) }
  scope :by_recipients, ->(recipient) { where(recipients: [recipient, :for_all]) }

  scope :scope_races,   ->(scope) { send(scope) if methods.include?(scope.to_sym) }

  # scope :group_by_categories,           -> { group(:category).category.name }


  def set_draft
    self.status ||= :draft
  end

  def decrement_open_race_reward
    owner.reward.decrement_open_races
  end

  def likes
    Event.where(thing_type: 'Race', thing_id: id, message: 'add_like')
  end

  def completed_percentage
    (value_covered.to_f / race_value.to_f * 100).to_i
  end

  # validations for publishing race
  def publishable?
    owner.valid_attribute?(:rui) && owner.has_reward?('open') ? true : false
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
    value_covered = 0
    attendees.confirmed.each { |attendee| value_covered += attendee.pieces.sum :value }
    value_covered
  end

  def remaining_value
    race_value - value_covered
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
    if Event.where(thing_type: 'Race', thing_id: id, who_did: who_did, message: 'add_like').first
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

  # set redirect_path after create to redirect race after payola one time pay
  def set_redirect_path
    update_column(:redirect_path, "/races/#{id}/publish_check?kind=open")
  end

  def set_permalink
    self.permalink = loop do
      random_token = SecureRandom.hex(4)
      break random_token unless Race.exists?(permalink: random_token)
    end
  end

  def initialize_race
    set_permalink
    self.name ||= permalink
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
end
