When(/^I stop race$/) do
  find("#stop_button").click
end


And(/^I start race$/) do
  find("#start_button").click
end

When(/^I join to public race for (\d+) times$/) do |arg1|
  arg1 = arg1.to_i

  count = 1
  arg1.times do
    user = create(:user, email:"test_email_#{count}@test.com")
    create(:race, name:"test_private_race_#{count}", kind: 'pay_for_join', owner: user, permalink: count)
    count += 1
  end

  count = 1
  arg1.times do
    visit "/races"
    find("#test_private_race_#{count}").click
    find("#test_private_race_#{count}").click

    fill_in "join_value", :with => '1000'

    find("#join").click
    count += 1
  end
end

And(/^I join with "([^"]*)" in a race with value "([^"]*)"$/) do |arg1, arg2|
  user = create(:user, email:"test_email@test.com")
  create(:race, name:"test_private_race", kind: 'pay_for_join', owner: user, race_value:arg2)

  visit "/races"
  find("#test_private_race").click
  find("#test_private_race").click

  fill_in "join_value", :with => arg1

  find("#join").click
end

When(/^I join in "([^"]*)" with "([^"]*)" euro$/) do |arg1, arg2|
  visit "/races"

  find("##{arg1}").click
  find("##{arg1}").click

  fill_in "join_value", :with => arg2

  find("#join").click
end
