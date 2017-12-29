Given(/^I sign up/) do
  visit('/users/sign_up')

  # find('Id or class here').set('some text')
  fill_in('email', with: 'new_user@test.com')
  fill_in('password', with: '1234567')
  find("#agreed").click
  # check('agreed')

  click_on('ENTRA')
end

Given(/^I logged in having basic account/) do
  $user = create(:user, name: "basic",
                 plan: Plan.find_by_stripe_id('basic'),
                 email:'basic_user_test@email.com',
                 password: "test_password",
                 intent: :attendee)

  login_as($user, :scope => :user)

  visit('/')
  expect(page).to have_content "Dashboard"
end

Given(/^I logged in having creator account/) do
  $user = create(:user, name: "creator",
                 plan: Plan.find_by_stripe_id('pro_creator'),
                 email:'creator_user_test@email.com',
                 intent: :creator,
                 password: "test_password")

  login_as($user, :scope => :user)

  visit('/')
  expect(page).to have_content "Dashboard"
end

Given(/^I logged in having attendee account/) do
  $user = create(:user, name: "Attendee",
                 plan: Plan.find_by_stripe_id('pro_attendee'),
                 email:'attendee_user_test@email.com',
                 intent: :attendee,
                 password: "test_password")

  login_as($user, :scope => :user)

  visit('/')
  expect(page).to have_content "Dashboard"
end