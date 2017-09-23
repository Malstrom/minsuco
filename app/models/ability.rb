class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    alias_action :index, :show, :readed, :to => :read
    alias_action :new, :to => :create
    alias_action :edit, :to => :update

    alias_action :user_races, :to => :read_created_races
    alias_action :publish, :publish_check, :to => :publish_race

    # #user
    can :manage, User,id: user.id

    #race
    can :read, Race
    can :read_created_races, Race, owner:user
    can :create, Race, owner:user
    can :publish_race, Race, owner:user
    can :update, Race, owner:user
    can :like, Race
    can :public_url, Race

    #attendee
    can :read, Attendee, user:user
    can :create, Attendee
    can :destroy, Attendee, user:user
    can :update, Attendee do |attendee|
      attendee.user == user and
      attendee.race.owner == user
    end

    #friends
    can :manage, Friend, user:user

    #events
    can :read, Event do |event|
      user.channels.include?(event.channel)
    end

    # channels_subscription
    can :update, ChannelSubscription, user:user
  end
end
