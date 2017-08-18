
# # Race create steps

# I create "private/public" race
When(/^I create (public|private|\d+) race$/) do |kind|
  if kind == public
    create(:race, name: arg1, kind: "pay_for_publish", owner: User.first)
  else
    create(:race, name: arg1, kind: "pay_for_join", owner: User.first)
  end
end

# I create "private/public" race with "" = ""
When(/^I create (public|private|\d+) race with '([^']*)' = '([^']*)'$/) do |kind,field,value|
  if kind == public
    create(:race, name: arg1, kind: "pay_for_publish", owner: User.first, "#{field}" => value)
  else
    create(:race, name: arg1, kind: "pay_for_join", owner: User.first , "#{field}" => value)
  end
end

# I fill race form
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

# I fill in race form "attr_name" with "attr_value"
# I publish race as "public/private"
# I fill in rui modal

# # Race Join steps

# I click to "start/stop" race button
# I join in a "public/private" races for "n" times
# I join in a race with "" join_value
# I join in a full race



