class ApplicationController < ActionController::Base
  layout :layout_by_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def dashboard
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
