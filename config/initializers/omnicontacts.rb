require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, "1087195332078-bat7rqbbhden22h241b66bouolkmhgbs.apps.googleusercontent.com", "DMcHo-Hdko0ipMgR3nDGhr-j", :max_results => 20000
  importer :facebook, "1881943605403586", "ca4f5f01f33656d2d5d742c69d326095"
end