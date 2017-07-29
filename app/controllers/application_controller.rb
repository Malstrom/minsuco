class ApplicationController < ActionController::Base
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

  def layout_by_resource
    if devise_controller?
      "pages"
    else
      "application-main"
    end
  end

  # def invite
  #   @contacts = request.env['omnicontacts.contacts']
  #   @user = current_user
  #
  #   unless @contacts.nil?
  #     @contacts.each do |contact|
  #       @user.friends.create(name:contact[:name], email:contact[:email]) if contact[:email]
  #     end
  #   end
  # end
end
