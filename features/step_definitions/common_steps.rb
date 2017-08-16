When(/^I click to "([^"]*)"$/) do |arg|
  click_on(arg)
end

When(/^I visit "([^"]*)"$/) do |arg1|
  visit arg1
end

When(/^I visit my races page$/) do
  user = User.find_by_email("new_user@test.com")
  visit("/users/#{user.id}/races")
end

When(/^I visit "([^"]*)" race page$/) do |arg|
  race = Race.find_by_name(arg)
  visit race_path(race)
end

When(/^I visit attendees page$/) do
  visit("/users/#{$user.id}/attendees")
end


Then(/^I should see "([^"]*)"/) do |arg1|
  expect(page).to have_content arg1
end

And(/^I sleep "([^"]*)" seconds$/) do |arg1|
  sleep arg1.to_i
end

Then(/^I click on notifications$/) do
  visit '/'
  find('#notification').click
end

Then(/^I "([^"]*)" join$/) do |arg|
  find('#confirm_toggle').click
end