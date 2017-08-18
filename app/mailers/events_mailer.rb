class EventsMailer < ApplicationMailer
  default :from => 'events@minusco.com'

  # arrive all requests
  def event_mailer(event)
    event.channel.users.each do |recipient|
      new_request(event, recipient)
    end
  end

  # send requests
  def new_request(event, recipient)
    event_params(event, recipient)
    mail(to: recipient.email, subject: t("email.events.#{event.message}.subject"))
  end

  #pass json for transactional email
  def event_params(event, recipient)
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
