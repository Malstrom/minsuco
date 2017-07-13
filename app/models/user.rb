class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :races
  has_many :authorizations
  has_one :subscription, ->(sub) { where.not(stripe_id: nil) }, class_name: Payola::Subscription, foreign_key: :owner_idx

  enum role: [:user, :admin, :silver, :gold, :platinum]
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_default_plan, :if => :new_record?
  # after_create :sign_up_for_mailing_list

  belongs_to :plan
  validates_associated :plan

  def set_default_role
    self.role ||= :user
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

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.image = auth.info.image # assuming the user model has an image
  #   end
  # end

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
      authorization.user_id = user.id
    end
    authorization.save
    authorization.user
  end

end
