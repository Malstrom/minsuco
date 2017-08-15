When(/^I create private race name "([^"]*)"$/) do |arg1|
  create(:race, name: arg1, kind: "pay_for_join", owner: User.first)
end

When(/^I create public race name "([^"]*)"$/) do |arg1|
  create(:race, name: arg1, kind: "pay_for_publish", owner: User.first)
end

When(/^I fill race form$/) do
  fill_in "name", :with => 'TestRace'
  fill_in "description", :with => 'A test race'
  fill_in "race_value", :with => '100000'
  fill_in "pieces_amount", :with => '50'
  fill_in "max_attendees", :with => '50'
  fill_in "compensation_amount", :with => '20'
  fill_in "start_date", :with => Time.now.strftime("%m/%d/%Y")
  fill_in "end_date", :with => Time.now.strftime("%m/%d/%Y")

  # select('auto', from: 'race_category_id', visible:false)
  # select('Tutti', from: 'race_recipients', visible:false)

  click_on('Pubblica la gara')
end

When(/^I fill race attribute "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in "name", :with => 'TestRace'
  fill_in "description", :with => 'A test race'
  fill_in "race_value", :with => '100000'
  fill_in "pieces_amount", :with => '50'
  fill_in "max_attendees", :with => '50'
  fill_in "compensation_amount", :with => '20'
  fill_in "start_date", :with => Time.now.strftime("%m/%d/%Y")
  fill_in "end_date", :with => Time.now.strftime("%m/%d/%Y")

  # select('auto', from: 'race_category_id', visible:false)
  # select('Tutti', from: 'race_recipients', visible:false)

  fill_in arg1, :with => arg2 if arg1 and arg2

  click_on('Pubblica la gara')
end

def fill_race_form

end

When(/^I publish race as "([^"]*)"$/) do |arg1|
  if arg1 == 'private'
    find('#pay_for_join').click
    click_on('Pubblica la gara')
  elsif arg1 == 'public'
    find('#pay_for_publish').click
    click_on('Pubblica la gara')
  elsif arg1 == 'public_basic_user'
    find('#pay_for_publish').click
    click_on('Paga e rendi la gara pubblica')

    within_frame 'stripe_checkout_app' do
      find_field('Card number').send_keys(4242424242424242)
      find_field('MM / YY').send_keys "01#{DateTime.now.year + 1}"
      find_field('CVC').send_keys '123'

      find('button[type="submit"]').click
    end
    page.has_content?('Success!')
  end
end

When(/^I fill rui with "([^"]*)"$/) do |arg1|
  find("#myModal").find("#user_rui").set arg1
  find("#myModal").click_on('Save changes')
end

When(/^I close rui modal$/) do
  find("#closeMyModal").click
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

