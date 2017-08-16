Given /^a user named "([^"]*)" is online$/ do |name|
  using_session(name) do
    step %{I logged in as a "#{name}"}
  end
end

Then /^([^I]+) should see notification "([^"]*)"$/ do |name, text|
  using_session(name) do
    step %{I click on notifications}
    step %{I should see "#{text}"}
  end
end

Then(/^I click on notifications$/) do
  visit '/'
  find('#notification').click
end


