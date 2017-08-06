class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user
        can :manage, :all
      end

      # elsif user.pro_attendee?
      #   can :read, Race
      #   can :new, Race
      #   can :create, Race
      #   can :attendees, Race
      #   can :user_races, Race
      #   can :publish_new, Race
      #   can :publish_check, Race, Race do |race|
      #     if race.kind == 'pay_for_publish'
      #       true if current_user.pro_creator? or race.owner.have_reward?('public_publish')
      #     else
      #       true
      #     end
      #   end
      # end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
