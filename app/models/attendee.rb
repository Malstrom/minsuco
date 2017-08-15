class Attendee < ApplicationRecord

  belongs_to :user
  belongs_to :race

  validate :max_attendee, :unique_join, :not_joinable, :self_join, :race_value_cap

  after_create :decrement_rewards

  after_create_commit { create_event }

  private

  def decrement_rewards
    user.reward.decrement_join_private unless user.plan.stripe_id == "pro_attendee"
  end

  # check if attendee has permission to join the race (subscription, kind of race, free join token, ecc...)
  def not_joinable
    unless user.has_plan_for_join?
      unless user.has_reward?('pay_for_join')
        errors.add(:invalid_plan, I18n.t('activerecord.errors.models.attendee.invalid_plan'))
        errors.add(:not_joinable, I18n.t('activerecord.errors.models.attendee.no_reward'))
      end
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
    if race.value_coverage + join_value > race.race_value
      errors.add(:race_value_cap, I18n.t('activerecord.errors.models.attendee.race_value_cap'))
    end
  end

  # create event every type create attendee
  def create_event
    Event.create(thing_type: 'Attendee', thing_id:id, message:'join in race',
                 owner: user, recipient: race.owner,
                 notifiable: true, read: false
    )
  end
end
