# I create "private/public" race
When(/^(I|Someone|\d+) create (public|private|\d+) race$/) do |who,kind|
  if who == 'I'
    if kind == 'public'
      race = build(:race, name: kind, kind: "open", owner: User.first)
      race.commissions.new
      race.save
    else
      race = build(:race, name: kind, kind: "close", owner: User.first)
      race.commissions.new
      race.save
    end
  else
    if kind == 'public'
      race = build(:race, name: kind, kind: "open", owner: create(:user))
      race.commissions.new
      race.save
    else
      race = build(:race, name: kind, kind: "close", owner: create(:user))
      race.commissions.new
      race.save
    end
  end
end

Given(/^User (basic|attendee|creator\d+) create (public|private|\d+) race$/) do |who,kind|
  kind == 'public' ? kind = 'open' : kind = 'close'

  case who
    when 'basic'
      race = build(:race, kind: kind, owner: create(:user, plan: Plan.find_by_stripe_id('basic')))
      race.commissions.new
      race.save
    when 'creator'
      race = build(:race, kind: kind, owner: create(:user, plan: Plan.find_by_stripe_id('pro_creator')))
      race.commissions.new
      race.save
    when 'attendee'
      race = build(:race, kind: kind, owner: create(:user, plan: Plan.find_by_stripe_id('pro_attendee')))
      race.commissions.new
      race.save
  end
end

# I create "private/public" race with "" = ""
When(/^(I|Someone|\d+) create (public|private|\d+) race with '([^']*)' = '([^']*)'$/) do |who,kind,field,value|
  if who == 'I'
    if kind == 'public'
      race = build(:race, name: kind, kind: "open", owner: User.first, "#{field}" => value)
      race.commissions.new
      race.save
    else
      race = build(:race, name: kind, kind: "close", owner: User.first, "#{field}" => value)
      race.commissions.new
      race.save
    end
  else
    if kind == 'public'
      race = build(:race, name: kind, kind: "open", owner: create(:user), "#{field}" => value)
      race.commissions.new
      race.save
    else
      race = build(:race, name: kind, kind: "close", owner: create(:user), "#{field}" => value)
      race.commissions.new
      race.save
    end
  end
end

# I fill race form
When(/^I fill race form$/) do
  visit "/races/new"

  fill_in "race_name", :with => 'Test race name'
  fill_in "race_description", :with => 'A test race'
  fill_in "race_race_value", :with => '100000'
  fill_in "race_starts_at", :with => Time.now.strftime("%m/%d/%Y")
  fill_in "race_ends_at", :with => (Time.now + 2.days).strftime("%m/%d/%Y")

  page.execute_script "window.scrollBy(0,10000)"


  click_on('CREA GARA')
end

# I fill race attribute "" with ""
When(/^I fill race attribute "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  visit "/races/new"

  fill_in "race_name", :with => 'race test'
  fill_in "race_description", :with => 'A test race'
  fill_in "race_race_value", :with => '100000'
  fill_in "race_starts_at", :with => Time.now.strftime("%m/%d/%Y")
  fill_in "race_ends_at", :with => Time.now.strftime("%m/%d/%Y")

  fill_in arg1, :with => arg2 if arg1 and arg2

  page.execute_script "window.scrollBy(0,10000)"

  find('#race_create').click
  # click_on('CREA GARA')
end

When(/^I publish race as (open|close|pay|\d+)$/) do |arg1|
  race = Race.first
  visit "races/#{race.id}/publish"

  if arg1 == 'close'
    click_on('Pubblica la gara come chiusa')
  elsif arg1 == 'open'
    click_on('Pubblica come gara aperta')
  elsif arg1 == 'pay'
    click_on('Paga e pubblica')

    within_frame 'stripe_checkout_app' do
      find_field('Card number').send_keys(4242424242424242)
      find_field('MM / YY').send_keys "01#{DateTime.now.year + 1}"
      find_field('CVC').send_keys '1234'

      find('button[type="submit"]').click
    end
    page.has_content?('Success!')
  end
end

# I fill data in rui modal "" value
When(/^I fill data in rui modal '([^']*)' value '([^']*)'$/) do |field,value|

  fill_user_form(field,value)

  # find("#userDataModal").find("##{id}").set value

  find("#userDataModal").click_on('Aggiorna profilo')
end

When(/^I fill user modal$/) do
  fill_in 'user_rui', :with => 'b123456789'
  fill_in 'user_phone', :with => '353452435'

  find("#userDataModal").click_on('Aggiorna profilo')
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

And(/^I have create (\d+) open races$/) do |arg|
  race = build(:race, kind:'open', owner:User.first)
  race.commissions.new
  race.save
end

When(/^I should not change category of race$/) do
  raise "updated" if Race.update(category:Category.last)
end