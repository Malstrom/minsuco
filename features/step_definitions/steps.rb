Given(/^I logged in as a "([^"]*)"$/) do |arg1|
  visit('/users/sign_up')

  fill_in('user_email', with: 'TestUser')
  fill_in('user_password', with: '1234567')
  check('agreed')

  click_on('Sign up')

  expect(page).to have_content 'Success'
end

Then(/^I should see "([^"]*)" page$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I logged in as a "([^"]*)" with social "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should not see "([^"]*)" page$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I click to "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I should see "([^"]*)" form$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I submit new race named "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I pay race named "([^"]*)"$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" race published with kind "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Given(/^I click to "([^"]*)" button$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)" alert$/) do |arg1|
  pending # Write code here that turns the phrase above into concrete actions
end
