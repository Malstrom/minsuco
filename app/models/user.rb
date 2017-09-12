class User < ApplicationRecord

  # need for tag users with interested categories
  acts_as_taggable
  acts_as_taggable_on :interests

  # many to one plan with one subscription on it
  belongs_to    :plan
  has_one :subscription, ->(sub) { where.not(stripe_id: nil) }, class_name: 'Payola::Subscription', foreign_key: :owner_idx

  # many to many with races using attendee
  has_many      :attendees
  has_many      :races, class_name: 'Race', through: :attendees
  has_many      :races, :foreign_key => "owner_id"

  # many to many channels using channel_subscriptions
  has_many      :channel_subscriptions
  has_many      :channels, class_name: 'Channel', through: :channel_subscriptions

  # many events as recipient and as a "who did the action"
  has_many      :events, :foreign_key => "who_did_id", dependent: :destroy

  # auth
  has_many      :authorizations, dependent: :destroy

  # many friends imported from social
  has_many      :friends, dependent: :destroy

  # rewards for using free application
  has_one :reward

  # todo consider remove role and use plan only
  enum role:        [:basic, :pro_attendee, :pro_creator, :premium, :enterprise, :banned, :admin]

  enum kind:        [:broker, :agent, :sub_agent]
  enum fiscal_kind: [:individual, :company]

  # who user want to do in this app
  enum intent:      [:creator, :attendee]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_plan,    :if => :new_record?
  after_initialize :set_default_rewards, :if => :new_record?

  validates_presence_of :email
  validates :email, uniqueness: true
  #
  validates_presence_of :company_name, :fiscal_code, on: :update, :if => lambda { self.company? }
  validates_presence_of :name, :fiscal_code,         on: :update, :if => lambda { self.individual? }

  validates_presence_of :address, :city, :zip, :address_num, on: :update

  validates :rui, length: { minimum: 10 }, on: :update

  validates_associated :plan

  after_create_commit :create_default_channels

  scope :attendee_users, -> { where("intent = ?", :attendee) }
  scope :creator_users,  -> { where("intent = ?", :creator) }

  scope :who_receive_notifications_via_mail, -> { joins(:channel_subscriptions).where('channel_subscriptions.email_muted = ?', false) }
  scope :who_receive_notifications_via_app,  -> { joins(:channel_subscriptions).where('channel_subscriptions.in_app_muted = ?', false) }

  def private_channel
    Channel.find_by_name "#{id}_user_channel"
  end

  def attendee(race)
    Attendee.find_by_race_id(race.id)
  end

  def has_plan_for_join?
    plan == Plan.find_by_stripe_id('pro_attendee') or plan == Plan.find_by_stripe_id('premium') ? true : false
  end

  def has_plan_for_publish?
    plan == Plan.find_by_stripe_id('pro_creator') or plan == Plan.find_by_stripe_id('premium') ? true : false
  end

  def has_reward?(kind)
    case kind
      when 'pay_for_publish'
        reward.public_races > 0 ? true : false
      when 'pay_for_join'
        reward.join_private > 0 ? true : false
      else
        false
    end
  end

  def owner?(race)
    (race.owner == self) ? true : false
  end

  def joined?(race)
    attendee = Attendee.where(user: self, race: race).first
    attendee ? attendee : false
  end

  def participation(race)
    Attendee.where(user:self, race:race).first
  end

  def unread_events
    @events = Event.where(read:false, channel:channels)
  end

  def create_default_channels
    ChannelSubscription.create user_id:self.id, channel: Channel.find_or_create_by(name:"#{self.id}_user_channel")
  end

  def set_default_role
    self.role ||= :basic
  end

  def set_default_plan
    self.plan ||= Plan.find_by_stripe_id('basic')
  end

  def set_default_rewards
    self.reward ||= Reward.create
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.from_omniauth(auth)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s).first_or_initialize
    authorization.token = auth.credentials.token
    if authorization.user.blank?
      user = User.where('email = ?', auth["info"]["email"]).first
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.email = auth.info.email
        user.name = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image

        user.save
      end
      user.image = auth.info.image
      user.save
      authorization.user_id = user.id
    end
    authorization.save
    authorization.user
  end

  def self.from_omniauth_google(auth)
    authorization = Authorization.where(:provider => auth.provider, :uid => auth.uid.to_s).first_or_initialize
    authorization.token = auth.credentials.token
    if authorization.user.blank?
      user = User.where('email = ?', auth["info"]["email"]).first
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0,10]
        user.email = auth.info.email
        user.name = auth.info.name   # assuming the user model has a name
        user.image = auth.info.image # assuming the user model has an image

        user.save
      end
      user.image = auth.info.image
      user.save
      authorization.user_id = user.id
    end
    authorization.save
    authorization.user
  end
end
