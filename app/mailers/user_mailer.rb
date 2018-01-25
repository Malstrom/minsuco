class UserMailer < ApplicationMailer

  def welcome(user)
    email_params(user)
    mail(to: user.email, subject: t('email.invite.in_my_race.subject'))
  end

  # pass json for transactional email
  def email_params(user)
    headers 'X-SMTPAPI' => {
        'to' => [user.email],
        'sub' => {
            '%nome_cognome%' => [user.name]
        },
        'filters' => {
            'templates' => {
                'settings' => {
                    'enable' => 1,
                    'template_id' => '052314f3-79c1-456f-b9b9-98c4358c17e7'
                }
            }
        }
    }.to_json
  end
end
