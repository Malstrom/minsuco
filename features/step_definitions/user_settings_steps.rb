And(/^I change my "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
  fill_in 'rui', :with => "12345"
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