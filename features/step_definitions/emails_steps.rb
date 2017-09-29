
When(/^I invite friend "([^"]*)"$/) do |email|
  sleep 1

  find(:id, "emails").attribute(email)
  # find(".bootstrap-tagsinput").set email

  click_on "Invia email"
end

When(/^I invite all friends from my list$/) do
  click_on "Lista contatti di google"
  click_on "Invita amici"
end

And(/^I have friend with email "([^"]*)"$/) do |email|
  create :friend, email: email, user: User.first
end

When(/^I invite "([^"]*)" from my list$/) do |arg|
  click_on "Lista contatti di google"
  find("##{arg}_check").click
  click_on "Invita amici"
end