
# SendGrid.configure do |config|
#   config.dummy_recipient = 'noreply@doktify.com'
# end



# ActionMailer::Base.register_interceptor(SendGrid::MailInterceptor)
#
# if ENV['SENDGRID_USERNAME'] && ENV['SENDGRID_PASSWORD']
#   ActionMailer::Base.smtp_settings = {
#       :address        => 'smtp.sendgrid.net',
#       :port           => '465',
#       :authentication => :plain,
#       :user_name      => ENV['SENDGRID_USERNAME'],
#       :password       => ENV['SENDGRID_PASSWORD'],
#       :domain         => 'heroku.com',
#       :enable_starttls_auto => true,
#       :ssl => true
#   }
#   ActionMailer::Base.delivery_method = :smtp
# end
#
# SendGrid.configure do |config|
#   config.dummy_recipient = 'email@myinsurancecontest.com'
# end