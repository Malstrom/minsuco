class RaceMailer < ApplicationMailer
  def owner_emails(race, template_id)
    email_params(race, template_id)
    mail(to: race.owner.email)
  end

  # pass json for transactional email
  def email_params(race, template_id)
    headers 'X-SMTPAPI' => {
      'to' => [race.owner.email],
      'sub' => {
        '%nome_cognome%' => [race.owner.name],
        '%link%' => [race_url(race)]
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
