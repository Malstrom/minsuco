class Attendee < ApplicationRecord

  belongs_to :user
  belongs_to :race

  has_many :pieces, :dependent => :destroy

  accepts_nested_attributes_for :pieces, allow_destroy: true

  enum status: [:confirmed, :deny, :waiting, :banned]

  # validates_associated :user, :race

  validate :unique_join, :joinable, :self_join, :race_target_cap, on: :create

  before_create :set_status

  after_create :decrement_private_join_rewards, if: proc { |attendee| attendee.race.close? }

  after_create_commit   :join_in_race_event
  after_destroy_commit	:leave_from_race_event

  scope :confirmed, -> { where status: :confirmed }

  def commission
    join_value / 100 * race.commission
  end

  private

  def decrement_private_join_rewards
    unless user.plan.stripe_id == "pro_attendee" or race.open?
      user.reward.decrement_join_private
    end
  end

  # check if attendee has permission to join the race (subscription, kind of race, free join token, ecc...)
  def joinable
    if !user.rui?
      errors.add(:no_rui, I18n.t('activerecord.errors.models.attendee.no_rui', :user_id => user.id ))
    elsif race.close? and !user.has_plan_for_join? and !user.has_reward?('close')
      errors.add(:invalid_plan, I18n.t('activerecord.errors.models.attendee.invalid_plan', :user_id => user.id))
      errors.add(:not_reward, I18n.t('activerecord.errors.models.attendee.no_reward', :user_id => user.id))
    elsif user.kind != race.recipients
      unless race.recipients == 'for_all'
        errors.add(:different_recipient, I18n.t('activerecord.errors.models.attendee.different_recipient'))
      end
    else
    end
  end

  def self_join
    if race.owner_id == user_id
      errors.add(:self_join, I18n.t('activerecord.errors.models.attendee.self_join'))
    end
  end

  def unique_join
    if Attendee.exists?(user: user, race: race)
      errors.add(:unique_join, "User must join only one time")
    end
  end

  def race_target_cap
    if race.value_covered + pieces.sum(&:value) > race.race_value
      errors.add(:race_target_cap, I18n.t('activerecord.errors.models.attendee.race_target_cap'))
    end
  end

  def set_status
    self.status = :confirmed
  end

  # create event every time create attendee
  def join_in_race_event
    ChannelSubscription.create user:user, channel: Channel.find_or_create_by(name:"#{race.id}_race_channel")
    create_attendee_event(user,"#{race.owner.id}_user_channel",'join_in_race', true)
  end

  # create event every time attendee leave from race
  def leave_from_race_event
    # create_attendee_event(user,"#{race.owner.id}_user_channel",'leave_from_race', true)
    # ChannelSubscription.where(user:user, channel: Channel.find_by_name("#{race.id}_race_channel")).first.destroy
  end

  def create_attendee_event(who_did, channel, message, notifiable, previous = nil, now = nil)
    Event.create(thing_type: 'Attendee', thing_id:id, message:message, who_did: who_did,
                 channel: Channel.find_or_initialize_by(name:channel),
                 previous: previous, now: now, notifiable: notifiable, read: false)
  end
end
