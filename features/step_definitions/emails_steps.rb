
When(/^I invite friend "([^"]*)"$/) do |email|
  sleep 1

  find(:xpath,'/html/body/div[1]/section/div/div[2]/div[2]/div[2]/div/div/form/fieldset/div/div/div/input').set(email)

  # find(:id, "emails").attribute(email)
  # find(".bootstrap-tagsinput").set email

  click_on "Invia email"
end

When(/^I invite all friends from my list$/) do
  click_on "Lista contatti di google"
  click_on "Invita amici"
end

And(/^I have friend with email "([^"]*)"$/) do |email|
  $friend = create :friend, email: email, user: User.first
end

When(/^I invite "([^"]*)" from my list$/) do |arg|
  click_on "Lista contatti di google"
  sleep 1
  find(:xpath,'//*[@id="1"]').click
  click_on "Invita amici"
end