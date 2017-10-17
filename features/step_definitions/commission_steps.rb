And(/^Exists a race "([^"]*)" with duration "([^"]*)" years and "([^"]*)"% revenue$/) do |name, arg1, arg2|
  race = build(:race, kind:'open', name:name)
  race.commissions.build(duration:arg1, value:arg2)
  race.save
end

And(/^I add a piece named "([^"]*)" having "([^"]*)" value, "([^"]*)" years duration$/) do |arg1, arg2, arg3|
  create(:piece,
        attendee:create(:attendee, race:Race.first, user: User.first),
        name:arg1, value:arg2, duration:arg3)
end