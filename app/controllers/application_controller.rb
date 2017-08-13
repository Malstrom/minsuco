class ApplicationController < ActionController::Base

  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, :set_events, :set_intent

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

  def set_events
    if current_user
      @events = Event.where(recipient_id: current_user.id, read: false, notifiable: true)
    end
  end

  def set_intent
    if params[:intent]
      current_user.intent = params[:intent]
      current_user.save
    end
  end


end
