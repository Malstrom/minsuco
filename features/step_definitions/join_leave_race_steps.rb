When(/^I stop race$/) do
  page.execute_script "window.scrollBy(0,400)"
  find("#stop_button").click
end

And(/^I start race$/) do
  page.execute_script "window.scrollBy(0,400)"
  find("#start_button").click
end

When(/^I visit a (open|close|\d+) race$/) do |kind|
  race = build(:race, name:kind , kind: kind, owner: create(:user), permalink: kind)
  race.commissions.new
  race.save
  visit race_path(race)
end

When(/^I join with (\d+) pieces to join named '([^']*)' with '([^']*)' value for '([^']*)' years/) do |qt,name,value,years|
  join_steps(qt,name,value,years)
end

When(/^I join in a full race$/) do
  race = build(:race, name: "test_private_race")
  race.commissions.new
  race.save

  10.times do
    user = create(:user, email: Faker::Internet.free_email)
    create(:attendee, race:race, user:user)
  end

  join_steps
end

When(/^I join in a race with (\d+) join value where race value is (\d+)$/) do |join_value, race_value|
  race = build(:race, name: "test_private_race", race_value: race_value)
  race.commissions.new
  race.save
  visit race_path(race)
  join_steps
end

When(/^I have '([^']*)' rewards for (join|publish|\d+)$/) do |n, reward|
  if reward == 'join'
    User.first.reward.update(join_private: n )
  else
    User.first.reward.update(open_races: n )
  end
end

When(/^I join in race of '([^']*)' user/) do |owner|
  race = build :race, name: "race_of_#{owner}" , owner: User.find_by_name(owner)
  race.commissions.new
  race.save
  visit race_path(race)
  join_steps
end

def join_steps(qt = 0, name = "first", value = "10000", duration = "1")
  first("#open_join_modal").click

  if qt.to_i > 0
    add_piece(qt,name,value,duration)
  else
    sleep 0.3
    find('#remove_piece').click
  end
  sleep 0.3
  find("#join").click
end

def fill_rui_modal(rui, phone = "33300099944")
  fill_in "user_rui", :with => rui
  fill_in "user_phone", :with => phone

  find("#userDataModal").click_on('Aggiorna profilo')
end


def add_piece(qt = 1, name = "first", value = "10000", duration = "1")
  count = 0
  qt.to_i.times do
    sleep 1
    fill_in "attendee_pieces_attributes_0_name", :with => name
    fill_in "attendee_pieces_attributes_0_value", :with => value
    fill_in "attendee_pieces_attributes_0_duration", :with => duration
    find("#add_piece").click if qt.to_i > 1
    count += 1
  end
end

When(/^I not have reward for (join|publish|\d+) race$/) do |reward|
  if reward == 'join'
    User.first.reward.update(join_private: 0 )
  else
    User.first.reward.update(open_races: 0 )
  end
end


# log,race,close/open rui, join.


Given(/^I already join in a race$/) do
  user = create(:user, email:"attendee@test.com", rui:"a123456789")
  race = build(:race)
  race.commissions.new
  race.save
  create(:attendee, race:race, user:user)
end

Then(/^I should fail to join one more time$/) do
  begin
    create(:attendee, race:Race.first, user:User.find_by_email('attendee@test.com'))
  rescue
      true
  else
    raise "User joined two time"
  end
end

Given(/^I am a agent$/) do
  create(:user, email:"attendee@test.com", rui:"a123456789", kind: "agent")
end

When(/^There is a race only for brokers$/) do
  race = build(:race, recipients: "broker")
  race.commissions.new
  race.save
end

Then(/^I should not join$/) do
  begin
    create(:attendee, race:Race.first, user:Race.first.owner)
  rescue
    true
  else
    raise "User joined in a race with different recipients"
  end
end

Given(/^I create race$/) do
  user = create(:user, email:"attendee@test.com", rui:"a123456789")
  race = build(:race, owner: user)
  race.commissions.new
  race.save
end

When(/^I update my join piece named '([^']*)' with '([^']*)' value for '([^']*)' years/) do |name,value,duration|
  join_steps(1,name,value,duration)
end


