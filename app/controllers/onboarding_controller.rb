class OnboardingController < ApplicationController
  layout 'pages'

  def index

  end

  def new_contest
  end

  def join_contest
  end

  def invite
    @contacts = request.env['omnicontacts.contacts']
    @user = request.env['omnicontacts.user']
  end

end
