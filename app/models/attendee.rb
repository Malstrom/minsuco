class Attendee < ApplicationRecord

  belongs_to :attendee, :class_name => 'User'
  belongs_to :race

  validate :max_attendee, :unique_join, :not_joinable, :self_join

  after_create :decrement_rewards

  after_create_commit { create_event }

  private

  def decrement_rewards
    attendee.reward.decrement_join_private unless attendee.plan.stripe_id == "pro_attendee"
  end

  # check if attendee has permission to join the race (subscription, kind of race, free join token, ecc...)
  def not_joinable
    unless attendee.has_plan_for_join?
      unless attendee.has_reward?('pay_for_join')
        errors.add(:invalid_plan, I18n.t('activerecord.errors.models.attendee.invalid_plan'))
        errors.add(:not_joinable, I18n.t('activerecord.errors.models.attendee.no_reward'))
      end
    end
  end

  def self_join
    if race.owner_id == attendee_id
      errors.add(:self_join, I18n.t('activerecord.errors.models.attendee.self_join'))
    end
  end

  def max_attendee
    if race.attendees.count >= race.max_attendees
      errors.add(:max_attendee, I18n.t('activerecord.errors.models.attendee.max_attendees'))
    end
  end

  def unique_join
    if Attendee.exists?(attendee: attendee, race: race)
      errors.add(:unique_join, "User must join only one time")
    end
  end

  # create event every type create attendee
  def create_event
    Event.create(thing_type: 'Attendee', thing_id:id, message:'join in race',
                 owner: attendee, recipient: race.owner,
                 notifiable: true, read: false
    )
  end
end
