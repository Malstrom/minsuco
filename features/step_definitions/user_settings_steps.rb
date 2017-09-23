And(/^I change my "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
  fill_in 'user_rui', :with => "12345678910"
  fill_in arg1, :with => arg2, :match => :prefer_exact
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
  click_on('IL MIO PROFILO')

  fill_user_form

  click_on "Aggiorna informazioni"
end

Then(/^'([^']*)' attribute '([^']*)' should '([^']*)'$/) do |model, attr, value|
  sleep 0.5
  klass = Object.const_get model
  user = klass.first
  value_saved = user.instance_eval(attr).to_s
  raise "Different value saved: #{value_saved}, should be: #{value}" if user.instance_eval(attr).to_s != value.to_s
end

When(/^I click to '([^']*)' element$/) do |arg|
  find("##{arg}").click
end

def fill_user_form(field = nil, value = nil)
  fill_in 'user_rui', :with => 'b123456789'
  fill_in 'user_name', :with => 'user_test', :match => :prefer_exact
  fill_in 'user_phone', :with => '353452435'
  fill_in 'user_city', :with => 'Milan'
  fill_in 'user_company_name', :with => 'Minmin'
  fill_in 'user_address', :with => 'minmin strett'
  fill_in 'user_address_num', :with => '77'
  fill_in 'user_city', :with => 'Mincity'
  fill_in 'user_zip', :with => '77777'
  fill_in 'user_fiscal_code', :with => '77777234234'

  if field and value
    fill_in field, :with => value
  end
end