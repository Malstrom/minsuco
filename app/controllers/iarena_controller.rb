class IarenaController < ApplicationController

  def authorize
    redirect_to Rails.application.secrets.iarena_authorization_url
  end

  def iarena_sign_up

    # request.headers["iarena"]
    # create ruby object from json
    auth = JSON.parse(params.to_json, object_class: OpenStruct)
    #auth = JSON.parse(request.headers["iarena"], object_class: OpenStruct)
     #JSON.parse(request.headers["iarena"])

    #token verifying
    # unless auth.credentials.token == Rails.application.secrets.iarena_token
    #   redirect_to new_user_registration_url, alert: "Richiesta ricevuta da fonte non autorizzata"
    # end

    @user = User.from_i_arena(auth)

    # raise Rails.application.secrets.key_encrypt
    crypt = ActiveSupport::MessageEncryptor.new(ENV['secret'])
    encrypted_data = crypt.encrypt_and_sign(@user.email)

    respond_to do |format|
      msg = { :status => "ok", :message => "Success!", :code => encrypted_data }
      format.json  { render :json => msg } # don't do msg.to_json
    end
  end

  def iarena_sign_in
    crypt = ActiveSupport::MessageEncryptor.new(ENV['secret'])
    user_email = crypt.decrypt_and_verify(params[:code])
    @user = User.find_by_email(user_email)

    if @user
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Iarena'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.iarena_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
    end
  end

  def insert_invoice
    invoice_id = params[:invoice_id]
  end

  #get invoice pdf from insurance arena
  def pdf
    invoice_id = params[:invoice_id]
  end

end
