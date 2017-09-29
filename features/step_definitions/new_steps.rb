When(/^'([^']*)' join in my race$/) do |who|
  create(:attendee, user:create(:user, email:'tes@tgam.it', name:who), race:create(:race, owner: User.first) )
end

Then(/^I should see '([^']*)' in a race page$/) do |who|
  visit race_path(Race.first)
  expect(page).to have_content who
end

Given(/^Race have (\d+) perc commission from (\d+) to (\d+) years$/) do |value, starts, ends|
  create(:commission, race: create(:race), value: value, starts: starts, ends: ends)
end

When(/^'([^']*)' join in race with piece named '([^']*)' value '([^']*)' for (\d+) years$/) do |attendee,name,value,duration|
  create(:piece,
         attendee: create(:attendee,
                          user: create(:user, name: attendee, email:'john@rerg.of'),
                          race: Race.first
         ),
         duration: duration,
         name:name,
         value:value)
end

Then(/^'([^']*)' should (\d+) of total revenue$/) do |attendee, total_revenue|
  attendee_total_revenue = User.find_by_name(attendee).attendees.first.total_revenue
  raise "Attendee total revenue is #{attendee_total_revenue}" unless attendee_total_revenue == total_revenue
end

When(/^I fill in user profile "([^"]*)" in "([^"]*)"$/) do |value, field|
  visit edit_user_path(User.all.first)
  fill_in field, :with => value
  page.execute_script "window.scrollBy(0,10000)"
  click_on "Aggiorna informazioni"
end
