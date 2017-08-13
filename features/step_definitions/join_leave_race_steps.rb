When(/^I stop race$/) do
  find("#stop_button").click
end


And(/^I start race$/) do
  find("#start_button").click
end

When(/^I join to public race for (\d+) times$/) do |arg1|
  arg1 = arg1.to_i

  count = 1
  arg1.times do
    user = create(:user, email:"test_email_#{count}@test.com")
    create(:race, name:"test_private_race_#{count}", kind: 'pay_for_join', owner: user, permalink: count)
    count += 1
  end

  count = 1
  arg1.times do
    visit "/races"
    find("#test_private_race_#{count}").click
    find("#test_private_race_#{count}").click
    count += 1
  end
end