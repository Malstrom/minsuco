class ApplicationController < ActionController::Base
  layout :layout_by_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def after_login
    if current_user.sign_in_count == 1
      redirect_to kind_onboarding_index_path
    else
      redirect_to dashboard_dashboard_path
    end
  end

  private

  def layout_by_resource
    if devise_controller?
      "pages"
    else
      "application-main"
    end
  end


end
