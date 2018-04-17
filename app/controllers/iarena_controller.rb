class IarenaController < ApplicationController

  def authorize
    redirect_to Rails.application.secrets.iarena_authorization_url
  end

  def sign_up
    # create ruby object from json
    auth = JSON.parse(params.to_json, object_class: OpenStruct)

    #token verifying
    unless auth.credentials.token == Rails.application.secrets.iarena_token
      redirect_to new_user_registration_url, alert: "Richiesta ricevuta da fonte non autorizzata"
    end

    #save_user
    @user = User.from_i_arena(auth)

    if @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Iarena'
      sign_in :user, @user
      # redirect_to root_path
    else
      session['devise.iarena_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

end
