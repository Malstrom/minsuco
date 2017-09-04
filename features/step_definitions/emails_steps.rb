
When(/^I invite friend "([^"]*)"$/) do |email|
  fill_in "friend_email", :with => email
  click_on "Invita"
end

When(/^I invite all friends from my list$/) do
  click_on "Miei contatti"
  click_on "Invita amici"
end

And(/^I have friend with email "([^"]*)"$/) do |email|
  create :friend, email: email, user: User.first
end