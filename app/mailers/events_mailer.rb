class EventsMailer < ApplicationMailer
  default :from => 'events@minusco.com'

  # arrive all requests
  def event_mailer(event)

    event.channel.users.who_receive_notifications_via_mail.each do |recipient|
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
            "%recipient_name%"  => ["#{recipient.name}}"],
            "%who_did%"         => ["#{event.who_did}"],
            "%race_name%"       => ["#{Attendee.find(event.thing_id).race.name}"],
        },
        "filters"=> {
            "templates"=> {
                "settings"=> {
                    "enable"=> 1,
                    "template_id"=> set_template_id(event)
                }
            }
        }
    }.to_json
  end

  def set_template_id(event)
    case event.message
      when 'join_in_race'
        "0abae4a2-45ec-4c7f-8978-faec11bb01da"
      when 'leave_from_race'
        "0abae4a2-45ec-4c7f-8978-faec11bb01da"
      else
        "0abae4a2-45ec-4c7f-8978-faec11bb01da"
    end
  end
end
