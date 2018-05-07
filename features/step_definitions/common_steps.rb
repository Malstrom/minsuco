When(/^I click to "([^"]*)"$/) do |arg|
  click_on(arg, match: :first)
end

When(/^I visit "([^"]*)"$/) do |arg1|
  visit arg1
end

When(/^I visit my races page$/) do
  user = User.first
  visit("/users/#{user.id}/races")
end

When(/^I visit "([^"]*)" race page$/) do |arg|
  race = Race.find_by_name(arg)
  visit race_path(race)
end

When(/^I visit attendees page$/) do
  visit("/users/#{User.first.id}/attendees")
end

Then(/^I should see "([^"]*)"$/) do |arg1|
  sleep 0.5
  expect(page).to have_content arg1
end

Then(/^I should not see "([^"]*)"$/) do |arg1|
  expect(page).to have_no_content arg1
end

And(/^I sleep "([^"]*)" seconds$/) do |arg1|
  sleep arg1.to_i
end

Then(/^I click on notifications$/) do
  visit '/'
  find('#notification').click
  sleep 0.5
end

Then(/^I "([^"]*)" join$/) do |arg|
  find('#confirm_toggle').click
end

And(/^I visit user setting page$/) do
  visit 'users/1/edit'
end

Then(/^I should have '([^']*)' free public race$/) do |n|
  raise User.first.reward.open_races if User.first.reward.open_races != n.to_i
end

Then(/^I should have '([^']*)' free private join/) do |n|
  raise User.first.reward.join_private if User.first.reward.join_private != n.to_i
end

And(/^I sort by category "([^"]*)"$/) do |category|
  pending
end

And(/^I order by "([^"]*)" s "([^"]*)"$/) do |arg1, arg2|
  pending
end

And(/^I fill "([^"]*)" in "([^"]*)" input$/) do |value, field|
  fill_in field, :with => value
end


def select_from_chosen(item_text, options)
  field_id = find_field(options[:from])[:id]
  within "##{field_id}_chzn" do
    find('a.chzn-single').click
    input = find("div.chzn-search input").native
    input.send_keys(item_text)
    find('ul.chzn-results').click
    input.send_key(:arrow_down, :return)
    within 'a.chzn-single' do
      page.should have_content item_text
    end
  end
end

def select_from_multi_chosen(item_text, options)
  field_id = find_field(options[:from])[:id]
  within "##{field_id}_chzn" do
    input = find("ul.chzn-choices input").native
    input.send_keys(item_text)
    input.send_key(:return)
    within 'ul.chzn-choices' do
      page.should have_content item_text
    end
  end
end

Given(/^Create list of races$/) do
  user = create :user, email:'user@email.com'
  create :race, category: Category.find_by_name('auto'), owner: user, name: "test_race1"
  create :race, kind: 'open', owner: user, name: "test_race2"
  create :race, kind: 'close', owner: user, name: "test_race"
  create :race, commission: 10, owner: user, name: "test_race"
  create :race, commission: 20, owner: user, name: "test_race"
  create :race, ends_at: (Time.now + 100.hours).strftime("%d/%m/%Y"), owner: user, name: "test_race"
  create :race, ends_at: (Time.now + 90.hours).strftime("%d/%m/%Y"), owner: user, name: "test_race"
end

When(/^I select '([^']*)' from chosen '([^']*)'$/) do |item_text, select|
  select_from_chosen item_text, select
end