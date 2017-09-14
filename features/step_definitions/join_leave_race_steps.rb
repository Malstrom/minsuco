When(/^I stop race$/) do
  find("#stop_button").click
end

And(/^I start race$/) do
  find("#start_button").click
end

When(/^I join in a (open|close|\d+) race$/) do |kind|
  race = create(:race, name:kind , kind: kind, owner: create(:user), permalink: kind)
  join_steps race.name
end

When(/^I join in a full race$/) do
  race = create(:race, name: "test_private_race")

  10.times do
    user = create(:user, email: Faker::Internet.free_email)
    create(:attendee, race:race, user:user)
  end

  join_steps race.name
end

When(/^I join in a race with (\d+) join value where race value is (\d+)$/) do |join_value, race_value|
  race = create(:race, name: "test_private_race", race_value: race_value)
  join_steps race.name, join_value
end

When(/^I have '([^']*)' rewards for (join|publish|\d+)$/) do |n, reward|
  if reward == 'join'
    User.first.reward.update(join_private: n )
  else
    User.first.reward.update(public_races: n )
  end
end

When(/^I join in race of '([^']*)' user/) do |owner|
  race = create :race, name: "race_of_#{owner}" , owner: User.find_by_name(owner)
  join_steps race.name
end

def join_steps(race_name, join_value = 1000)
  visit "/races"

  find("##{race_name}").click
  find("#open_join_modal").click

  fill_in "join_value", :with => join_value

  find("#join").click
end

When(/^I not have reward for (join|publish|\d+) race$/) do |reward|
  if reward == 'join'
    User.first.reward.update(join_private: 0 )
  else
    User.first.reward.update(pubic_races: 0 )
  end
end