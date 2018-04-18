class ApplicationController < ActionController::Base

  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :set_paper_trail_whodunnit
  before_action :authenticate_user!, :except => [:public_url, :sign_up, :authorize]
  before_action :load_notifications, :set_intent
  before_action :set_current_locale

  # before_action :save_url_in_history, except: [:history_back, :create, :destroy, :update]
  # after_action  :remove_last_from_history, only: :history_back

  rescue_from CanCan::AccessDenied do |_exception|
    respond_to do |format|
      flash[:danger] = 'Non sei autorizzato ad accedere a questa pagina'
      format.json { head :forbidden, content_type: 'text/html' }
      format.html { redirect_to main_app.root_url }
      format.js   { head :forbidden, content_type: 'text/html' }
    end
  end

  # def history_back
  #   session[:history].pop # remove current url
  #   previous_path = session[:history].last
  #   if previous_path
  #     redirect_to previous_path
  #   else
  #     redirect_to root_path
  #   end
  # end

  # remove history_back_path after_action
  def remove_last_from_history
    session[:history].pop
  end

  private

  # remove admin panel for devise controllers
  def layout_by_resource
    if devise_controller?
      'pages'
    elsif action_name == "public_url"
      'race_public'
    else
      'application'
    end
  end

  # set what user want to do: create races or join in race
  def set_intent
    current_user.update_attribute :intent, params[:intent] if params[:intent]
  end

  # set notifications for users
  def load_notifications
    @events = current_user.unread_events if current_user
  end

  def set_current_locale
    request.env['app.current_locale'] = I18n.locale.to_s
  end

  # save navigation history of users
  # def save_url_in_history
  #   session[:history] ||= []
  #
  #   if request.path != session[:history].last
  #     unless request.xhr? or params[:action] == 'publish' or params[:action] == 'create' or params[:action] == 'update'
  #       session[:history] << request.path
  #     end
  #   end
  # end
end
