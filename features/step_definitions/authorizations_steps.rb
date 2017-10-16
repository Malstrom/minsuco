When(/^I visit edit page of another user$/) do
  user = create(:user, email:'another_user@test.com', password:"testtest")
  visit "users/#{user.id}/edit"
end

When(/^I visit edit race page of another user$/) do
  race = build(:race, owner:create(:user, email:'igormir@te.it'))
  race.commissions.new
  race.save
  visit edit_race_path(race)
end
