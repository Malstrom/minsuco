# Given(/^I sign up/) do
#   visit('/users/sign_up')
#
#   # find('Id or class here').set('some text')
#   fill_in('email', with: 'new_user@test.com')
#   fill_in('password', with: '1234567')
#   find("#agreed").click
#   # check('agreed')
#
#   click_on('Sign up')
#
# end
#
# Given(/^I logged in as a "([^"]*)"$/) do |arg|
#   if arg == 'basic user'
#     $user = create(:user, name: arg, plan: Plan.find_by_stripe_id('basic'))
#   elsif arg == 'pro attendee user'
#     $user = create(:user, name: arg, plan: Plan.find_by_stripe_id('pro_attendee'))
#   elsif arg == 'pro creator user'
#     $user = create(:user, name: arg, plan: Plan.find_by_stripe_id('pro_creator'))
#   end
#   login_as($user, :scope => :user)
#
#   visit('/')
#   expect(page).to have_content "La mia Dashboard"
# end
#
# Then(/^I should see "([^"]*)"/) do |arg1|
#   expect(page).to have_content arg1
# end
#
# When(/^I click to "([^"]*)"$/) do |arg|
#   click_on(arg)
# end
#
# When(/^I visit my races page$/) do
#   visit("/users/#{$user.id}/races")
# end
#
# When(/^I visit attendees page$/) do
#   visit("/users/#{$user.id}/attendees")
# end
#
#
# When(/^I visit "([^"]*)"$/) do |arg1|
#   visit arg1
# end
#
# When(/^I create private race name "([^"]*)"$/) do |arg1|
#   create(:race, name: arg1, kind: "pay_for_join", owner: $user)
# end
#
# When(/^I create public race name "([^"]*)"$/) do |arg1|
#   create(:race, name: arg1, kind: "pay_for_publish", owner: $user)
# end
#
# When(/^I fill race form$/) do
#   fill_in "name", :with => 'TestRace'
#   fill_in "description", :with => 'A test race'
#   fill_in "race_value", :with => '100000'
#   fill_in "pieces_amount", :with => '50'
#   fill_in "max_attendees", :with => '50'
#   fill_in "compensation_amount", :with => '20'
#   fill_in "start_date", :with => Time.now.strftime("%m/%d/%Y")
#   fill_in "end_date", :with => Time.now.strftime("%m/%d/%Y")
#
#   select('auto', from: 'race_category_id', visible:false)
#
#   click_on('Pubblica la gara')
# end
#
# When(/^I fill race attribute "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
#   fill_in "name", :with => 'TestRace'
#   fill_in "description", :with => 'A test race'
#   fill_in "race_value", :with => '100000'
#   fill_in "pieces_amount", :with => '50'
#   fill_in "max_attendees", :with => '50'
#   fill_in "compensation_amount", :with => '20'
#   fill_in "start_date", :with => Time.now.strftime("%m/%d/%Y")
#   fill_in "end_date", :with => Time.now.strftime("%m/%d/%Y")
#
#   select('auto', from: 'race_category_id', visible:false)
#   select('Tutti', from: 'race_recipients', visible:false)
#
#   fill_in arg1, :with => arg2 if arg1 and arg2
#
#   click_on('Pubblica la gara')
# end
#
# When(/^I publish race as "([^"]*)"$/) do |arg1|
#   if arg1 == 'private'
#     find('#pay_for_join').click
#     click_on('Pubblica la gara')
#   elsif arg1 == 'public'
#     find('#pay_for_publish').click
#     click_on('Pubblica la gara')
#   elsif arg1 == 'public_basic_user'
#     find('#pay_for_publish').click
#     click_on('Paga e rendi la gara pubblica')
#
#     within_frame 'stripe_checkout_app' do
#       find_field('Card number').send_keys(4242424242424242)
#       find_field('MM / YY').send_keys "01#{DateTime.now.year + 1}"
#       find_field('CVC').send_keys '123'
#
#       find('button[type="submit"]').click
#     end
#     page.has_content?('Success!')
#   end
# end
#
#
# When(/^I fill rui with "([^"]*)"$/) do |arg1|
#   find("#myModal").find("#user_rui").set arg1
#   find("#myModal").click_on('Save changes')
# end
#
#
# When(/^I join to public race for (\d+) times$/) do |arg1|
#   count = 1
#   arg1 = arg1.to_i
#
#   arg1.times do
#     user = create(:user, email:"test_email_#{count}@test.com")
#     create(:race, name:"test_private_race_#{count}", kind: 'pay_for_join', owner: user, permalink: count)
#     count += 1
#   end
#   count = 1
#   arg1.times do
#     visit "/races"
#     find("#test_private_race_#{count}").click
#     find("#test_private_race_#{count}").click
#     count += 1
#   end
# end
#
# When(/^I close rui modal$/) do
#   find("#closeMyModal").click
# end
#
#
# Given(/^I sleep "([^"]*)" seconds$/) do |arg1|
#   sleep arg1.to_i
# end
#
#
# When(/^I join in a full race$/) do
#   race = create(:race, name: "test_private_race")
#
#   10.times do
#     user = create(:user, email: Faker::Internet.free_email)
#     create(:attendee, race:race, attendee:user)
#   end
#
#   visit "/races"
#   find("#test_private_race").click
#   find("#test_private_race").click
#
# end
#
#
# def select_from_chosen(item_text, options)
#   field = find_field(options[:from])
#   option_value = page.evaluate_script("$(\"##{field[:id]} option:contains('#{item_text}')\").val()")
#   page.execute_script("value = ['#{option_value}']\; if ($('##{field[:id]}').val()) {$.merge(value, $('##{field[:id]}').val())}")
#   option_value = page.evaluate_script("value")
#   page.execute_script("$('##{field[:id]}').val(#{option_value})")
#   page.execute_script("$('##{field[:id]}').trigger('liszt:updated').trigger('change')")
# end
#
#
# When(/^I visit "([^"]*)" race page$/) do |arg|
#   race = Race.find_by_name(arg)
#   visit race_path(race)
# end
#
# When(/^I stop race$/) do
#   find("#stop_button").click
# end
#
#
# And(/^I start race$/) do
#   pending
# end