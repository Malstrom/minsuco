class AttendeeMailer < ApplicationMailer

  def attendee_emails(attendee, template_id)
    email_params(attendee, template_id)
    mail(to: attendee.user.email)
  end

  # pass json for transactional email
  def email_params(attendee, template_id)
    headers 'X-SMTPAPI' => {
        'to' => [attendee.user.email],
        'sub' => {
            '%nome_cognome%' => [attendee.user.name],
            '%link%' => [attendee_url(attendee)]
        },
        'filters' => {
            'templates' => {
                'settings' => {
                    'enable' => 1,
                    'template_id' => template_id
                }
            }
        }
    }.to_json
  end
  
end
