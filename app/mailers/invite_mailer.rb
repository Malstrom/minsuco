class InviteMailer < ApplicationMailer
  default from: 'invitation@minusco.com'
  layout false

  # arrive all requests
  def invite_friends(mails)
    mails = JSON.parse(mails)
    mails.each do |email|
      friend = Friend.find_by_email email
      new_request(friend)
    end
  end

  # send requests
  def new_request(friend)
    invite_params(friend)
    mail(to: friend.email, subject: t('email.invite.in_my_race.subject'))
  end

  # pass json for transactional email
  def invite_params(friend)
    headers 'X-SMTPAPI' => {
      'to' => [friend.email],
      'sub' => {
        '%who_did%' => [friend]
      },
      'filters' => {
        'templates' => {
          'settings' => {
            'enable' => 1,
            'template_id' => 'dc5e7367-bf74-4e49-bb2e-88aa5c2522f2'
          }
        }
      }
    }.to_json
  end
end
