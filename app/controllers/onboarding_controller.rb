class OnboardingController < ApplicationController
  layout 'pages'

  def kind
  end

  def invite
    @contacts = request.env['omnicontacts.contacts']
    @user = current_user

    unless @contacts.nil?
      @contacts.each do |contact|
        @user.friends.create(name:contact[:name], email:contact[:email]) if contact[:email]
      end
    end
  end
end
