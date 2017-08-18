class MyMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions
    devise_params(user, recipient)

    mail(from: 'confirm_password@myinsurencecontest.com',
         to: recipient.email,
         subject: t("email.events.#{event.message}.subject")
    )
    super
  end

  def reset_password_instructions
    devise_params(user, recipient)

    mail(from: 'reset_password_instructions@myinsurencecontest.com',
         to: recipient.email,
         subject: t("email.events.#{event.message}.subject")
    )
    super
  end

  def unlock_instructions
    devise_params(user, recipient)

    mail(from: 'unlock_instructions@myinsurencecontest.com',
         to: recipient.email,
         subject: t("email.events.#{event.message}.subject")
    )
    super
  end

  #pass json for transactional email
  def devise_params(user, recipient)
    headers "X-SMTPAPI" => {
        "to"=> [ recipient.email ],
        "sub"=> {
            "%who_did%" => ["#{event.who_did}"],
        },
        "filters"=> {
            "templates"=> {
                "settings"=> {
                    "enable"=> 1,
                    "template_id"=> "dc5e7367-bf74-4e49-bb2e-88aa5c2522f2"
                }
            }
        }
    }.to_json
  end
end