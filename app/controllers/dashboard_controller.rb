class DashboardController < ApplicationController
  # load_and_authorize_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def dashboard
    @user = current_user

    unless @user.intent
      redirect_to user_intent_path @user
    end

  end
end
