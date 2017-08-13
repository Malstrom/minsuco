And(/^I change my "([^"]*)" in "([^"]*)"$/) do |arg1, arg2|
  fill_in 'rui', :with => "12345"
  fill_in arg1, :with => arg2
  click_on "Aggiorna informazioni"
end