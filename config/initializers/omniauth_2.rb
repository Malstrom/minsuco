# require 'omniauth-oauth2'
#
# module OmniAuth
#   module Strategies
#     class Iarena < OmniAuth::Strategies::OAuth2
#       # change the class name and the :name option to match your application name
#       option :name, :iarena
#
#       option :client_options, {
#           :site => "http://iarenatesting.azurewebsites.net",
#           :authorize_url => "/Admin/Login/LoginExternal",
#           # :token_url => '/Admin/Login/GetToken'
#       }
#
#       uid { raw_info["id"] }
#
#       info do
#         {
#             :email => raw_info["email"],
#             :name  => raw_info["name"]
#             # and anything else you want to return to your API consumers
#         }
#       end
#
#       def raw_info
#         @raw_info ||= access_token.get('/api/v1/me.json').parsed
#       end
#
#       # https://github.com/intridea/omniauth-oauth2/issues/81
#       def callback_url
#         full_host + script_name + callback_path
#       end
#
#     end
#   end
# end