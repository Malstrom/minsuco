class EventsMailer < ApplicationMailer

  def self.event(event)

    emails.each do |email|
      new_request(email).deliver_now
      # or
      #new_request(email,row).deliver_later

    end
  end

  def new_request(event)
    event_params(event)

    mail(from: 'notice@test.com',
         to: user.email,
         subject: "#{patient.name.capitalize} would like to have appointment with you")
  end

  def event_params(event)
    headers "X-SMTPAPI" => {
        "to"=> [ user.email ],
        "sub"=> {
            "%Name%" => ["#{user.fullname}"],
            "%patient_name%" => ["#{patient.name}"],
            "%message%" => ["#{event.description}"],
            "%phone%" => ["#{patient.phone}"],
            "%email%" => ["#{patient.email}"],
            "%date%" => ["#{event.start.to_date.strftime("%m/%d/%Y")}"],
            "%time%" => ["#{event.start.to_time.strftime("%l:%M")}"],
            "%user_id%" => ["#{user.id}"],
            "%event_id%" => ["#{event.id}"],
            "%token%" => ["#{token}"]
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
