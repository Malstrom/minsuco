When(/^I stop race$/) do
  find("#stop_button").click
end

And(/^I start race$/) do
  find("#start_button").click
end

When(/^I join in a (public|private|\d+) race$/) do |kind|
  kind == 'private' ? kind = 'pay_for_join' : kind = 'pay_for_publish'

  create(:race, name:"test_#{kind}_race", kind: kind, owner: create(:user), permalink: kind)

  visit "/races"
  find("#test_#{kind}_race").click
  find("#test_#{kind}_race").click

  fill_in "join_value", :with => '1000'

  find("#join").click
end

When(/^I join in a full race$/) do
  race = create(:race, name: "test_private_race", max_attendees: 10)

  10.times do
    user = create(:user, email: Faker::Internet.free_email)
    create(:attendee, race:race, user:user)
  end

  visit "/races"
  find("#test_private_race").click
  find("#test_private_race").click

  fill_in "join_value", :with => '1000'

  find("#join").click
end

When(/^I join in a race with (\d+) join value where race value is (\d+)$/) do |join_value, race_value|
  race = create(:race, name: "test_private_race", race_value: race_value)

  visit "/races"
  find("#test_private_race").click
  find("#test_private_race").click

  fill_in "join_value", :with => join_value

  find("#join").click
end

When(/^I have '([^']*)' rewards for (join|publish|\d+)$/) do |n, reward|
  if reward == 'join'
    User.first.reward.update(join_private: n )
  else
    User.first.reward.update(public_races: n )
  end
end

When(/^I join in race '([^']*)' named$/) do |name|
  visit "/races"
  find("##{name}").click
  find("##{name}").click

  fill_in "join_value", :with => 1000

  find("#join").click
end