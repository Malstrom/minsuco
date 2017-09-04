And(/^I change my "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
  fill_in 'rui', :with => "12345678910"
  fill_in arg1, :with => arg2
  click_on "Aggiorna informazioni"
end

And(/^I pay via stripe$/) do
  within_frame 'stripe_checkout_app' do
    find_field('Card number').send_keys(4242424242424242)
    find_field('MM / YY').send_keys "01#{DateTime.now.year + 1}"
    find_field('CVC').send_keys '123'

    find('button[type="submit"]').click
  end
  page.has_content?('Success!')
end

When(/^I visit user plan$/) do
  id = User.find_by_email("new_user@test.com").id
  visit "users/#{id}/plans"
end

And(/^I complete my profile$/) do
  click_on('IMPOSTAZIONI')

  fill_in 'rui', :with => "12345678910"
  fill_in 'name', :with => 'user_test'
  fill_in 'phone', :with => '353452435'
  fill_in 'location', :with => 'test_location'

  click_on "Aggiorna informazioni"
end

Then(/^'([^']*)' attribute '([^']*)' should '([^']*)'$/) do |model, attr, value|
  klass = Object.const_get model
  user = klass.first
  value_saved = user.instance_eval(attr).to_s
  raise "Different value saved: #{value_saved}, should be: #{value}" if user.instance_eval(attr).to_s != value.to_s
end

When(/^I click to '([^']*)' element$/) do |arg|
  find("##{arg}").click
end