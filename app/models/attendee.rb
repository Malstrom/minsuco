class Attendee < ApplicationRecord

  belongs_to :user
  belongs_to :race

  enum status: [:confirmed, :deny, :waiting, :banned]

  # validates_associated :user, :race

  validate :max_attendee, :unique_join, :not_joinable, :self_join, :race_value_cap, on: :create

  validates :join_value, numericality: { only_integer: true }

  validate :can_leave, on: :delete

  before_create :set_status

  after_create :decrement_rewards

  after_create_commit   :join_in_race_event
  after_update_commit	  :update_race_event
  after_destroy_commit	:leave_from_race_event

  private

  def decrement_rewards
    unless user.plan.stripe_id == "pro_attendee" or race.kind == 'pay_for_publish' or race.kind == "pay_for_publish"
      user.reward.decrement_join_private
    end
  end

  # check if attendee has permission to join the race (subscription, kind of race, free join token, ecc...)
  def not_joinable
    if !user.rui?
      errors.add(:no_rui, I18n.t('activerecord.errors.models.attendee.no_rui'))
    elsif !user.has_plan_for_join? and !user.has_reward?('pay_for_join')
      errors.add(:invalid_plan, I18n.t('activerecord.errors.models.attendee.invalid_plan'))
      errors.add(:not_reward, I18n.t('activerecord.errors.models.attendee.no_reward'))
    elsif user.kind != race.recipients
      unless race.recipients == 'for_all'
        errors.add(:different_recipient, I18n.t('activerecord.errors.models.attendee.different_recipient'))
      end
    else
      true
    end
  end

  def self_join
    if race.owner_id == user_id
      errors.add(:self_join, I18n.t('activerecord.errors.models.attendee.self_join'))
    end
  end

  def max_attendee
    if race.attendees.count >= race.max_attendees
      errors.add(:max_attendee, I18n.t('activerecord.errors.models.attendee.max_attendees'))
    end
  end

  def unique_join
    if Attendee.exists?(user: user, race: race)
      errors.add(:unique_join, "User must join only one time")
    end
  end

  def race_value_cap
    if race.value_covered + join_value > race.race_value
      errors.add(:race_value_cap, I18n.t('activerecord.errors.models.attendee.race_value_cap'))
    end
  end

  def can_leave
    if attendee.status == 'banned'
      errors.add(:can_leave, I18n.t('activerecord.errors.models.attendee.can_leave'))
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

  # create event every time attendee: update status, update join_value
  def update_race_event
    if previous_changes['status']
      prev_status = previous_changes['status'][0]
      create_attendee_event(race.owner,"#{user.id}_user_channel","change_status", true, prev_status, status, )
    elsif previous_changes['join_value']
      prev_join_value = previous_changes['join_value'][0]
      create_attendee_event( user,"#{race.owner.id}_user_channel", "change_join_value", true, prev_join_value)
    end
  end

  def create_attendee_event(who_did, channel, message, notifiable, previous = nil, now = nil)
    Event.create(thing_type: 'Attendee', thing_id:id, message:message, who_did: who_did,
                 channel: Channel.find_or_initialize_by(name:channel),
                 previous: previous, now: now, notifiable: notifiable, read: false)
  end
end
