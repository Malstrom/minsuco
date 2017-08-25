When(/^I stop race$/) do
  find("#stop_button").click
end

And(/^I start race$/) do
  find("#start_button").click
end

When(/^I join in a (public|private|\d+) race$/) do |kind|
  kind == 'private' ? kind = 'pay_for_join' : kind = 'pay_for_publish'

  race = create(:race, name:"test_#{kind}_race", kind: kind, owner: create(:user), permalink: kind)
  join_steps race
end

When(/^I join in a full race$/) do
  race = create(:race, name: "test_private_race", max_attendees: 10)

  10.times do
    user = create(:user, email: Faker::Internet.free_email)
    create(:attendee, race:race, user:user)
  end

  join_steps race
end

When(/^I join in a race with (\d+) join value where race value is (\d+)$/) do |join_value, race_value|
  race = create(:race, name: "test_private_race", race_value: race_value)
  join_steps race, join_value
end

When(/^I have '([^']*)' rewards for (join|publish|\d+)$/) do |n, reward|
  if reward == 'join'
    User.first.reward.update(join_private: n )
  else
    User.first.reward.update(public_races: n )
  end
end

When(/^I join in race of '([^']*)' user/) do |owner|
  race = create :race, owner: User.find_by_name(owner)
  join_steps race
end

def join_steps(race,join_value=1000)
  visit "/races"

  find("##{race.name}").click
  find("##{race.name}").click

  fill_in "join_value", :with => join_value

  find("#join").click
end