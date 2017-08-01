class User < ApplicationRecord

  belongs_to    :plan
  has_one :subscription, ->(sub) { where.not(stripe_id: nil) }, class_name: Payola::Subscription, foreign_key: :owner_idx

  has_many      :events, :foreign_key => "owner_id", dependent: :destroy
  has_many      :events, :foreign_key => "recipient_id", dependent: :destroy

  has_many      :friends, dependent: :destroy

  has_many      :authorizations, dependent: :destroy

  has_many      :races, :foreign_key => "owner_id"
  has_many      :attendees, :foreign_key => "attendee_id", :dependent => :destroy

  enum role:        [:basic, :pro_attendee, :pro_creator, :premium, :enterprise, :banned, :admin]

  enum kind:        [:broker, :agente]

  enum fiscal_kind: [:individual, :company]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]


  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_plan, :if => :new_record?
  # after_create :sign_up_for_mailing_list

  validates_associated :plan
  validates :email, uniqueness: true

  def set_default_role
    self.role ||= :basic
  end

  def set_default_plan
    self.plan ||= Plan.last
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # check if user have permission to join the race (subscription, kind of race, free join token, ecc...)
  def joinable?

  end

  def joined?(race)
    false
    true if self.attendees.where(race:race).first
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
