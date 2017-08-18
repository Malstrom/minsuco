ActionMailer::Base.smtp_settings = {
    :address        => 'smtp.sendgrid.net',
    :port           => '587',
    :authentication => :plain,
    :user_name      => Rails.application.secrets.sendgrind_username,
    :password       => Rails.application.secrets.sendgrind_password,
    :domain         => 'minsuco.herokuapp.com',
    :enable_starttls_auto => true
}

# SendGrid.configure do |config|
#   config.dummy_recipient = 'noreply@doktify.com'
# end