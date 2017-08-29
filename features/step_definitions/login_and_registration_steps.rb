Given(/^I sign up/) do
  visit('/users/sign_up')

  # find('Id or class here').set('some text')
  fill_in('email', with: 'new_user@test.com')
  fill_in('password', with: '1234567')
  find("#agreed").click
  # check('agreed')

  click_on('Sign up')
end

Given(/^I logged in as a "([^"]*)"$/) do |arg|
  user = User.find_by_name arg

  unless user
    if arg == 'basic'
      $user = create(:user, name: arg, plan: Plan.find_by_stripe_id('basic'), email:'basic_user_test@email.com')
    elsif arg == 'attendee'
      $user = create(:user, name: arg, plan: Plan.find_by_stripe_id('pro_attendee'), email:'pro_attendee_test@email.com')
    elsif arg == 'creator'
      $user = create(:user, name: arg, plan: Plan.find_by_stripe_id('pro_creator'), email:'pro_creator_test@email.com')
    end
  end
  login_as($user, :scope => :user)

  visit('/')
  expect(page).to have_content "La mia Dashboard"
end
