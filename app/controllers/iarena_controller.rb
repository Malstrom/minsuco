class IarenaController < ApplicationController

  def authorize
    redirect_to Rails.application.secrets.iarena_authorization_url
  end

  def iarena_sign_up
    # create ruby object from json
    auth = JSON.parse(params.to_json, object_class: OpenStruct)

    # token verifying
    unless auth.credentials.token == Rails.application.secrets.iarena_token
      redirect_to new_user_registration_url, alert: "Richiesta ricevuta da fonte non autorizzata"
    end

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
    #create ruby object
    e = JSON.parse(params.to_json, object_class: OpenStruct)

    #find user by customer_id arrived from e
    user  = Payola::Subscription.find_by_stripe_customer_id(e.data.object.customer).owner

    # uri = URI('http://iarenatesting.azurewebsites.net/Admin/ExternalInvoice/InvoiceInsert')

    uri = URI("#{ENV['iarenaurl']}/Admin/ExternalInvoice/InvoiceInsert")
    req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')


    req.body = {
        AddressStreet:        "#{user.address} #{user.address_num} #{user.city}",
        AddressRegion:        "#{user.zip}",
        Amount:               e.data.object.total,
        ContractDescription:  "Abbonamento mensile " + t("activerecord.attributes.user.roles.#{e.data.object.plan.id}"),
        InvoiceTax:           e.data.object.tax,
        IdTransaction:        e.data.object.id,
        IdUser:               "#{user.id}",
        PaymentType:          "stripe",
        Vat:                  user.fiscal_code,
        Denomination:         "#{user.name} #{user.fiscal_code}",
        InvoiceDate:          e.data.object.date,
        PeriodEndDate:        e.data.object.period_end,
        PeriodStartDate:      e.data.object.period_start
    }.to_json

    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(req)
    end
  end

  #get invoice pdf from insurance arena
  def pdf
    redirect_to "#{ENV['iarenaurl']}/Admin/ExternalInvoice/DownloadPdf?idTransaction=#{params[:invoice_id]}&lang=it"
  end

end
