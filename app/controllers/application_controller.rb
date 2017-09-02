class ApplicationController < ActionController::Base

  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :load_notifications, :set_intent

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      flash[:danger] = "Non sei autorizzato ad accedere a questa pagina"
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url}
      format.js   { head :forbidden, content_type: 'text/html' }
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

  # set what user want to do: create races or join in race
  def set_intent
    if params[:intent]
      current_user.update_attribute :intent, params[:intent]
    end
  end

  # def set_theme
  #   unless current_user.theme
  #     current_user.update_attribute :theme, 'theme-g'
  #   end
  # end

  # set notifications for users
  def load_notifications
    if current_user
      @events = current_user.unread_events
    end
  end
end
