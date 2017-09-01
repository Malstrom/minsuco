# I create "private/public" race
When(/^(I|Someone|\d+) create (public|private|\d+) race$/) do |who,kind|
  if who == 'I'
    if kind == 'public'
      create(:race, name: kind, kind: "pay_for_publish", owner: User.first)
    else
      create(:race, name: kind, kind: "pay_for_join", owner: User.first)
    end
  else
    if kind == 'public'
      create(:race, name: kind, kind: "pay_for_publish", owner: create(:user))
    else
      create(:race, name: kind, kind: "pay_for_join", owner: create(:user))
    end
  end
end

Given(/^User (basic|attendee|creator\d+) create (public|private|\d+) race$/) do |who,kind|
  kind == 'public' ? kind = 'pay_for_publish' : kind = 'pay_for_join'

  case who
    when 'basic'
      create(:race, kind: kind, owner: create(:user, plan: Plan.find_by_stripe_id('basic')))
    when 'creator'
      create(:race, kind: kind, owner: create(:user, plan: Plan.find_by_stripe_id('pro_creator')))
    when 'attendee'
      create(:race, kind: kind, owner: create(:user, plan: Plan.find_by_stripe_id('pro_attendee')))
  end
end

# I create "private/public" race with "" = ""
When(/^(I|Someone|\d+) create (public|private|\d+) race with '([^']*)' = '([^']*)'$/) do |who,kind,field,value|
  if who == 'I'
    if kind == 'public'
      create(:race, name: kind, kind: "pay_for_publish", owner: User.first, "#{field}" => value)
    else
      create(:race, name: kind, kind: "pay_for_join", owner: User.first, "#{field}" => value)
    end
  else
    if kind == 'public'
      create(:race, name: kind, kind: "pay_for_publish", owner: create(:user), "#{field}" => value)
    else
      create(:race, name: kind, kind: "pay_for_join", owner: create(:user), "#{field}" => value)
    end
  end
end

# I fill race form
When(/^I fill race form$/) do
  fill_in "name", :with => 'TestRace'
  fill_in "description", :with => 'A test race'
  fill_in "race_value", :with => '100000'
  # fill_in "min_pieces", :with => '50'
  # fill_in "max_attendees", :with => '50'
  fill_in "commission", :with => '20'
  fill_in "start_date", :with => Time.now.strftime("%m/%d/%Y")
  fill_in "end_date", :with => Time.now.strftime("%m/%d/%Y")

  # select('auto', from: 'race_category_id', visible:false)
  # select('Tutti', from: 'race_recipients', visible:false)

  click_on('Pubblica la gara')
end

# I fill race attribute "" with ""
When(/^I fill race attribute "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in "name", :with => 'TestRace'
  fill_in "description", :with => 'A test race'
  fill_in "race_value", :with => '100000'
  # fill_in "min_pieces", :with => '50'
  # fill_in "max_attendees", :with => '50'
  fill_in "commission", :with => '20'
  fill_in "start_date", :with => Time.now.strftime("%m/%d/%Y")
  fill_in "end_date", :with => Time.now.strftime("%m/%d/%Y")

  # select('auto', from: 'race_category_id', visible:false)
  # select('Tutti', from: 'race_recipients', visible:false)

  fill_in arg1, :with => arg2 if arg1 and arg2

  click_on('Pubblica la gara')
end

When(/^I publish race as "([^"]*)"$/) do |arg1|
  if arg1 == 'private'
    find('#pay_for_join').click
    click_on('Pubblica la gara')
  elsif arg1 == 'public'
    find('#pay_for_publish').click
    click_on('Pubblica la gara')
  elsif arg1 == 'public_basic_user'
    find('#pay_for_publish').click
    click_on('Paga e rendi la gara pubblica')

    within_frame 'stripe_checkout_app' do
      find_field('Card number').send_keys(4242424242424242)
      find_field('MM / YY').send_keys "01#{DateTime.now.year + 1}"
      find_field('CVC').send_keys '123'

      find('button[type="submit"]').click
    end
    page.has_content?('Success!')
  end
end

# I fill data in rui modal "" value
When(/^I fill data in rui modal '([^']*)' value '([^']*)'$/) do |id,value|
  find("#userDataModal").find("#user_rui").set 121345
  find("#userDataModal").find("#user_name").set 'test_user_name'
  find("#userDataModal").find("#user_phone").set '091238478932'
  find("#userDataModal").find("#user_location").set 'Milan'
  
  find("#userDataModal").find("##{id}").set value

  find("#userDataModal").click_on('Save changes')
end

When(/^I close rui modal$/) do
  find("#closeMyModal").click
end


When(/^([^I]+) request to join in "([^"]*)" race$/) do |arg1,arg2|
  create(:user, name: arg1, plan: Plan.find_by_stripe_id('basic'), email:'basic_user_test@email.com')

  using_session(arg1) do
    step %{I logged in as a "#{arg1}"}
    step %{I join with "#{arg2}" in a race with value "1000"}
  end
end

Given(/^User "([^"]*)" join in "([^"]*)" race$/) do |user_name, race_name|
  create :attendee,
         user: create(:user, name:user_name, email: "#{user_name}@test.com"),
         race: Race.find_by_name(race_name)
end