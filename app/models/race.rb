class Race < ApplicationRecord
  include Payola::Sellable

  # who create the race
  belongs_to :owner, class_name: 'User'

  # race have attendees and attendees are users
  has_many :attendees
  has_many :users, class_name: 'User', through: :attendees

  has_many :featured_races

  belongs_to :category

  enum kind:        [:pay_for_publish, :pay_for_join]
  enum status:      [:started, :paused, :draft, :achieved]
  enum recipients:  [:broker, :agent, :for_all]

  before_validation :set_permalink, on: :create

  validate          :start_in_past, on: :create

  validates :race_value, numericality: { only_integer: true }
  validate  :attendees_cap

  validate  :date_not_changed, :category_not_changed, :commission_not_decrased, :on => :update

  validates_presence_of :name, :description, :commission, :recipients, :race_value,
                        :category_id, :starts_at, :ends_at, :kind

  before_save   :sanitize_data
  after_create  :set_redirect_path

  before_update :set_status , if: Proc.new { |race| race.status.nil? or race.status == :draft }

  after_create_commit :subscribe_owner

  # Use like this "Race.started_races"
  scope :started_races, -> { where status: :started }
  scope :not_expired,   -> { where("ends_at > ?", DateTime.now)}
  scope :expired,       -> { where("ends_at < ?", DateTime.now)}

  scope :public_races,  -> { where( kind: :pay_for_publish) }
  scope :private_races, -> { where( kind: :pay_for_join) }

  scope :by_category,   -> (category)  { where( category: category ) }
  scope :by_owner,      -> (owner)     { where( owner: owner ) }
  scope :by_recipients, -> (recipient) { where( recipients: [recipient, :for_all] ) }


  def completed_percentage
    value_covered.to_f / race_value.to_f * 100
  end

  # all external validation needed for publish race
  def publishable?
    owner.valid?
  end

  # If owner payed for the race when publish as public race
  def payed?
    (PayolaSale.find_by_product_id(id) || owner.has_plan_for_publish?) ? true : false
  end

  # check by date and not by datetime for exclude race expired today
  def expired?
    ends_at.to_date < Date.today ? true : false
  end

  # Sum of all attendees join_value for this race
  def value_covered
    Attendee.where(race_id:self.id, status: 'confirmed').sum(:join_value)
  end

  def total_commission
    attendees.sum(:join_value) / 100 * commission
  end

  # set case and check if Owner not write prohibited data in fields like it s name or phone number
  def sanitize_data
    self.name.upcase!
    self.description.capitalize!
  end

  #create channel and subscription owner for receive notifications
  def subscribe_owner
    channel = Channel.create(name: "#{id}_race_channel")
    ChannelSubscription.create user:owner, channel: channel
  end

  private

  # SETTTERS
  def set_status
    publishable? ? self.status = :started : self.status = :draft
  end

  # set redirect_path after create to redirect race after payola one time pay
  def set_redirect_path
    update_column(:redirect_path, "/races/#{self.id}/publish_check?kind=pay_for_publish")
  end

  def set_permalink
    self.permalink = "#{Time.now.to_i}"
  end

  # CUSTOM VALIDATIONS
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

  # validation when update race
  def date_not_changed
    if starts_at_changed? or ends_at_changed? && self.persisted?
      errors.add(:start_and_end_cant_updated, I18n.t('activerecord.errors.models.race.start_and_end_cant_updated'))
    end
  end

  # validation when update race
  def category_not_changed
    if category_id_changed? && self.persisted?
      errors.add(:category_cant_updated, I18n.t('activerecord.errors.models.race.category_cant_updated'))
    end
  end

  # validation when update race
  def commission_not_decrased
    if commission < commission_was
      errors.add(:commission_cant_updated, I18n.t('activerecord.errors.models.race.commission_cant_updated'))
    end
  end
end
