Rails.application.config.middleware.use OmniAuth::Builder do
  # OmniAuth.config.test_mode = true
  #
  #
  # omniauth_hash = { 'provider' => 'i-arena',
  #                   'uid' => '12345',
  #                   'info' => {
  #                       'name' => 'natasha',
  #                       'email' => 'hi@natashatherobot.com',
  #                       'nickname' => 'NatashaTheRobot'
  #                   },
  #                   'extra' => {'raw_info' =>
  #                                   { 'location' => 'San Francisco',
  #                                     'gravatar_id' => '123456789'
  #                                   }
  #                   },
  #                   'credentials' => { 'token' => '5cc07c32-6985-iarena2018-995f-9e46511c000c'}
  # }
  #
  # OmniAuth.config.add_mock(:iarena, omniauth_hash)


  provider :iarena, 'i-arena', '5cc07c32-6985-iarena2018-995f-9e46511c000c', {:provider_ignores_state => true}
end
#
#
# OmniAuth.config.on_failure = Proc.new { |env|
#   OmniAuth::FailureEndpoint.new(env).redirect_to_failure
# }