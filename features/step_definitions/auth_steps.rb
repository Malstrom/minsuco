When(/^I visit edit page of another user$/) do
  user = create(:user, email:'another_user@test.com')
  visit "users/#{user.id}/edit"
end