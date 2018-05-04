Given /^a user named "([^"]*)" is online$/ do |name|
  using_session(name) do
    step %{I logged in having creator account}
  end
end

Then /^([^I]+) should see notification "([^"]*)"$/ do |name, text|
  sleep 1
  using_session(name) do
    step %{I click on notifications}
    step %{I should see "#{text}"}
  end
end

Then /^([^I]+) should see "([^"]*)" page when click to "([^"]*)"$/ do |name, race_name, text|
  using_session(name) do
    step %{I click to "#{text}"}
    step %{I should see "#{race_name}"}
  end
end

Then /^([^I]+) should see own race and notification become readed$/ do |name, text|
  using_session(name) do
    step %{I click to "readed"}
    step %{I should see "TestRace"}
    step %{I should not see "#{text}"}
  end
end

Then /^([^I]+) should "([^"]*)" join race "([^"]*)"/ do |user, status, race_name|
  race = Race.find_by_name(race_name)
  using_session(user) do
    step %{I visit "/races/#{race.id}"}
    step %{I "#{status}" join}
    step %{I should see "Partecipazione aggiornata"}
  end
end
